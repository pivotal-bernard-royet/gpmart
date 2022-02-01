create index online_sales_fact_part_i1 on online_sales.online_sales_fact_part (sale_date_key);
create index online_sales_fact_part_i2 on online_sales.online_sales_fact_part (warehouse_key);

create index store_sales_fact_part_i1 on store.store_sales_fact_part (date_key);
create index store_sales_fact_part_i2 on store.store_sales_fact_part (store_key);
