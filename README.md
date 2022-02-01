Introduction=	

GPMart is a set of tool to create a retail database and populate it with random data.
GPMart has been adapted to work with GreenPlum 

**gpmart_gen.cpp** is the data generator for the GPMart Example Database
as described in the Getting Started guide.

To build:

    make gpmart_gen

To run:

    ./gpmart_gen
    [ --datadirectory <dir-data-files> ]
    [ --files <fact-table-load-files> ]
    [ --null  <character-to-indicate-null-value> ]
    [ --seed  <for-random-number-generator> ]
    [ --time_file  <data-for-Date_Dimension> ]
    [ --store_sales_fact  <rows> ]
    [ --store_orders_fact  <rows> ]
    [ --product_dimension  <rows> ]
    [ --store_dimension  <rows> ]
    [ --promotion_dimension  <rows> ]
    [ --vendor_dimension  <rows> ]
    [ --customer_dimension  <rows> ]
    [ --employee_dimension  <rows> ]
    [ --warehouse_dimension <rows> ]
    [ --shipping_dimension <rows> ]
    [ --online_page_dimension <rows> ]
    [ --callcenter_dimension <rows> ]
    [ --online_sales_fact <rows> ]
    [ --inventory_fact <rows> ]
    [ --gen_load_script ]
    [ --years startYear-endYear ]
    
where the options can be in any order and only need to be long enough to be unique.

Example:

./gpmart_gen \
         --datadirectory /temp/gpmart_schema \
         --store_sales_fact 5000000 \
         --product_dimension 500 \
         --store_dimension 50 \
         --promotion_dimension 100 \
         --years 2012-2016

**gpmart_genTime.c** is to generate the time data in Time.txt.

To build:

    g++ gpmart_genTime.c -o gpmart_genTime
    chmod +x gpmart_genTime

To run:

    ./gpmart_genTime startYear endYear > Time.txt

1. startYear must be later than 1900.
2. startYear can't be larger than endYear.

Example:

./gpmart_genTime 2003 2018 > Time.txt


=	How to Create the database , generate the data , load the data :

**1) create the database**

Log in as gpadmin and then 

psql 
create database gpmart;
\q  

Create the database schema (v5 for GreenPlum v5.x , v6 for GreenPlum v6.x)

psql gpmart -f gpmart_define_schema_v6.sql

**2) Generate the data

Generate the data - use a directory where you have enough diskspace
Here's an example with a 50M rows store_sales_fact table

./gpmart_gen --datadirectory /data1/data_load --store_sales_fact 50000000 --product_dimension 5000 --store_dimension 500 --promotion_dimension 1000 --years 2012-2018 

**3) Load the data

Load the data into the gpmart database

./gpmart_gpload_data.sh /data1/data_load gpmart 

You can also create a store_sales_fact partitioned table 
psql gpmart -f gpmart_define_schema_part.sql

Generate the statistics
analyzedb -d gpmart
