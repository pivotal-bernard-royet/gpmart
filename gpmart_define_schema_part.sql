drop table if exists store.store_sales_fact_part;

CREATE TABLE store.store_sales_fact_part (
sales_date              date,
sales_month             integer,
sales_year              integer,
product_key             integer,
product_version         integer,
store_key               integer,
promotion_key           integer,
customer_key            integer,
employee_key            integer,
pos_transaction_number  integer,
sales_quantity          integer,
sales_dollar_amount     integer,
cost_dollar_amount      integer,
gross_profit_dollar_amount integer,
transaction_type        varchar(16),
transaction_time        time,
tender_type             varchar(8)
) WITH (appendonly=true, orientation=column,compresstype=rle_type)
DISTRIBUTED BY (sales_date)
PARTITION BY RANGE (sales_date)
(START (date '2000-01-01') INCLUSIVE
END (date '2020-12-31') INCLUSIVE
EVERY (INTERVAL '1 year'));

insert into store.store_sales_fact_part 
select D.date,D.calendar_month_number_in_year,D.calendar_year,
S.product_key,S.product_version ,       
S.store_key,              
S.promotion_key,          
S.customer_key ,          
S.employee_key ,          
S.pos_transaction_number ,
S.sales_quantity     ,    
S.sales_dollar_amount  ,  
S.cost_dollar_amount ,    
S.gross_profit_dollar_amount,
S.transaction_type   ,    
S.transaction_time ,      
S.tender_type              
from store.store_sales_fact S , date_dimension D
where S.date_key=D.date_key;

