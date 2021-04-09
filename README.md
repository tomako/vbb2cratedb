Assessment task for Crate.io

Requirements:
 * Docker

How to run:
 * Checkout the project and `cd` into the project folder
 * Run CrateDB in Docker
   
   `docker run -p 4200:4200 -p 5432:5432 crate`
 * Build image for the script

   `docker build -t vbb2cratedb .`
 * Run script in the container

    `docker run --rm --network="host" vbb2cratedb`

Few thoughts:
 * If no data transformation is needed I would prefer a simple approach using linux and db provided tools (like `wget`, `copy from csv-file`, etc). In this case I saw some transformation was needed (to better fit CrateDB dialect). However unfortunately I had no time to implement those transformations because spent too much time on fixing the discrepancies between the GTFS standard and VBB data. 
 * What is definitely missing: error handling, data validation/transformation, tests
