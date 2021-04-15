#!/bin/bash
docker cp vbb_schema cratedb:/
docker cp vbb_to_cratedb_in_docker.sh cratedb:/
docker exec -it cratedb chmod u+x /vbb_to_cratedb_in_docker.sh
docker exec -it cratedb /vbb_to_cratedb_in_docker.sh
docker exec -it cratedb rm -r /vbb_schema /vbb_to_cratedb_in_docker.sh