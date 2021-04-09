from argparse import ArgumentParser
from os import listdir
from os.path import join as join_path
from tempfile import TemporaryFile
from zipfile import ZipFile
import csv
import logging

import crate.client
import requests

CRATE_DB_URL = 'http://localhost:4200'
VBB_DATA_URL = 'https://www.vbb.de/media/download/2029'
VBB_DATA_FOLDER = './vbb_data'

ch = logging.StreamHandler()
fh = logging.FileHandler('logs/vbb_to_cratedb.log')
logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',
                    level=logging.INFO,
                    handlers=[ch, fh])
logger = logging.getLogger('vbb_to_cratedb')


def download(url=VBB_DATA_URL,
             output_folder=VBB_DATA_FOLDER):
    logger.info(f'Download data from {url} to {output_folder}')
    with TemporaryFile() as tmp_file:
        # download
        r = requests.get(url, stream=True)
        for chunk in r.iter_content(chunk_size=512):
            tmp_file.write(chunk)
        # extract
        with ZipFile(tmp_file) as zip_file:
            zip_file.extractall(output_folder)


def batch_dict_reader(dict_reader, batch_size):
    """Processing CSV records in batches"""
    batch = []
    for item in dict_reader:
        # TODO: Probably this would be slightly faster if eliminating DictReader
        batch.append(list(item.values()))
        if len(batch) >= batch_size:
            yield batch
            batch = []
    if batch:
        yield batch


def load(data_folder=VBB_DATA_FOLDER, db_url=CRATE_DB_URL):
    logger.info('Connect to CrateDB')
    with crate.client.connect(db_url) as conn:
        cur = conn.cursor()

        logger.info('Create db schema')
        with open('schema.sql') as schema:
            for query in schema.read().split(';'):
                if query.strip():
                    cur.execute(query)

        logger.info('Processing VBB data files')
        cur.execute('SHOW TABLES')
        existing_tables = [row[0] for row in cur.fetchall()]
        for data_file_name in listdir(data_folder):
            logger.info(f'Processing {data_file_name}')
            table_name = data_file_name.split('.')[0]
            if table_name in existing_tables:
                num_of_records = 0
                num_of_inserts = 0
                with open(join_path(data_folder, data_file_name)) as csv_file:
                    dict_reader = csv.DictReader(csv_file)
                    for batch in batch_dict_reader(dict_reader, 1000):
                        query = f'INSERT INTO {table_name} ({",".join(dict_reader.fieldnames)}) ' \
                                f'VALUES ({",".join("?" * len(dict_reader.fieldnames))})'
                        rs = cur.executemany(query, batch)
                        num_of_records += len(batch)
                        num_of_inserts += sum(row['rowcount'] for row in rs if row['rowcount'] > 0)
                msg = f'{table_name}: Inserted {num_of_inserts} of {num_of_records}'
                if num_of_inserts != num_of_records:
                    logger.warning(msg)
                else:
                    logger.info(msg)
            else:
                logger.warning(f'Missing db table for {data_file_name}')


def main(skip_download, skip_load):
    if not skip_download:
        download()
    if not skip_load:
        load()


if __name__ == '__main__':
    parser = ArgumentParser(description='Load VBB data to CrateDB')
    parser.add_argument('--skip-download', action='store_true',
                        help='Skip downloading data from internet')
    parser.add_argument('--skip-load', action='store_true',
                        help='Skip loading data into CrateDB')
    args = parser.parse_args()
    main(args.skip_download, args.skip_load)
