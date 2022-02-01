#!/bin/bash

if [ -z "$1" ]; then
  CONC=10
else
  CONC=$1
fi


# Keep running queries (using a vmart query as an example) in concurrent vsql threads.
for x in $(seq 1 "$CONC" )
  do 
         psql -U vmart1 -f vmart_queries.sql -o vmart_queries.vmart1.log vmart &
         psql -U vmart2 -f vmart_queries.sql -o vmart_queries.vmart2.log vmart &
         psql -U vmart3 -f vmart_queries.sql -o vmart_queries.vmart3.log vmart &
         psql -U vmart4 -f vmart_queries.sql -o vmart_queries.vmart4.log vmart &
         psql -U vmart5 -f vmart_queries.sql -o vmart_queries.vmart5.log vmart &
         psql -U vmart6 -f vmart_queries.sql -o vmart_queries.vmart6.log vmart &
         psql -U vmart7 -f vmart_queries.sql -o vmart_queries.vmart7.log vmart &
         psql -U vmart8 -f vmart_queries.sql -o vmart_queries.vmart8.log vmart &
         psql -U vmart9 -f vmart_queries.sql -o vmart_queries.vmart9.log vmart &
         psql -U vmart10 -f vmart_queries.sql -o vmart_queries.vmart10.log vmart
  done
