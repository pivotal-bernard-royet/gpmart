#!/bin/bash

if [ -z "$1" ]; then
  CONC=10
else
  CONC=$1
fi

database=gpmart

# Keep running queries (using a gpmart query as an example) in concurrent vsql threads.
for x in $(seq 1 "$CONC" )
  do 
         psql -U gpmart1 -f gpmart_queries.sql -o gpmart_queries.gpmart1.log $database &
         psql -U gpmart2 -f gpmart_queries.sql -o gpmart_queries.gpmart2.log $database &
         psql -U gpmart3 -f gpmart_queries.sql -o gpmart_queries.gpmart3.log $database &
         psql -U gpmart4 -f gpmart_queries.sql -o gpmart_queries.gpmart4.log $database &
         psql -U gpmart5 -f gpmart_queries.sql -o gpmart_queries.gpmart5.log $database &
         psql -U gpmart6 -f gpmart_queries.sql -o gpmart_queries.gpmart6.log $database &
         psql -U gpmart7 -f gpmart_queries.sql -o gpmart_queries.gpmart7.log $database &
         psql -U gpmart8 -f gpmart_queries.sql -o gpmart_queries.gpmart8.log $database &
         psql -U gpmart9 -f gpmart_queries.sql -o gpmart_queries.gpmart9.log $database &
         psql -U gpmart10 -f gpmart_queries.sql -o gpmart_queries.gpmart10.log $database
  done
