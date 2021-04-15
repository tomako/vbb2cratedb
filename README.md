# Assessment task for Crate.io

Requirements:
 * Docker

## Solution 1

Start CrateDB container and another one to run the loader script.

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
