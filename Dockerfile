FROM python:3.8-alpine

WORKDIR /vbb_to_crate/logs
WORKDIR /vbb_to_crate/vbb_data
WORKDIR /vbb_to_crate
COPY requirements.txt ./
COPY vbb_to_cratedb.py ./
COPY schema.sql ./

RUN pip3 install -r requirements.txt

ENTRYPOINT ["python3", "vbb_to_cratedb.py"]