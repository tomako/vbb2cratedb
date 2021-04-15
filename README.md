# Assessment task for Crate.io

Requirements:
 * Docker

One word about some SSL handshake issue I have experienced. According to Docker documentation "By default, all containers have networking enabled and they can make any outgoing connections."
For some reason downloading VBB data from the https site does not work for me. The SSL handshake gets stalled. It is for both python-requests and curl. I tried few things without success and eventually added the `--network="host"` parameter to run the container where the downloading got initiated.
I don't know the real reason yet so be aware this workaround might not be needed in your environment.

## Solution 1

Start CrateDB container and another one to run the loader script (python).

How to run:
 * `$ cd solution1`
 * Run CrateDB in Docker
   
   `docker run -p 4200:4200 -p 5432:5432 --name cratedb crate`
 * Build image for the loader script

   `docker build -t vbb2cratedb .`
 * Run the loader script in the container

    `docker run -it --rm vbb2cratedb`
   
   (Add `--network="host"` if the downloading VBB data from https doesn't work)

Notes:
 * If no data transformation is needed I would prefer a simple approach using linux and db provided tools (like `wget`, `copy from csv-file`, etc). In this case I saw some transformation was needed (to better fit CrateDB dialect). However unfortunately I had no time to implement those transformations because spent too much time on fixing the discrepancies between the GTFS standard and VBB data. 
 * What is definitely missing: error handling, data validation/transformation, tests
 * `executemany()` response does not have the `error_message` key (in my case) when failed and had to call them 1 by 1 to find out 
 * SQL parser has some issue with comments (expects semicolon after that)

## Solution 2

Start CrateDB container and run the import script (shell) in the same container.

How to run:
 * `$ cd solution2`
 * Run CrateDB in Docker
   
   `docker run -p 4200:4200 -p 5432:5432 --name cratedb crate`
   
   (Add `--network="host"` if the downloading VBB data from https doesn't work)
 * Run loader script

   `./vbb_to_cratedb.sh`

Notes:
 * I was curious whether it is possible to reproduce the same import using shell script and use Crate's own container. Well, it is. 
 * Crash has no CLI parameter to run SQL file directly so I had to split the schema file manually (the interactive shell has it though)
