
create schema store;
create schema online_sales;

create table customer_dimension
(	customer_key            integer         not null primary key,
	customer_type           varchar(16),
	customer_name           varchar(256),
	customer_gender         varchar(8),
	title                   varchar(8),
	household_id            integer,
        customer_address        varchar(256),
	customer_city           varchar(64),
	customer_state          char(2),
	customer_region         varchar(64),
	marital_status          varchar(32),
	customer_age            integer,
	number_of_children      integer,
	annual_income           integer,
	occupation              varchar(64),
	largest_bill_amount     integer,
	store_membership_card   integer,
	customer_since          date,
	deal_stage              varchar(32),
	deal_size               integer,
	last_deal_update        date
) DISTRIBUTED BY (customer_key);

create table product_dimension
(	product_key             integer         not null,
        product_version         integer         not null,
	product_description     varchar(128),
	sku_number              char(32),
	category_description    char(32),
	department_description  char(32),
	package_type_description char(32),
	package_size            char(32),
	fat_content             integer,
	diet_type               char(32),
	weight                  integer,
	weight_units_of_measure char(32),
	shelf_width             integer,
	shelf_height            integer,
	shelf_depth             integer,
	product_price           integer,
	product_cost            integer,
	lowest_competitor_price integer,
	highest_competitor_price        integer,
	average_competitor_price        integer,
	discontinued_flag       integer,
	primary key (product_key,product_version)
) DISTRIBUTED BY (product_key,product_version);

create table promotion_dimension ( 
	promotion_key integer not null primary key, 
	promotion_name varchar(128),
	price_reduction_type varchar(32), 
	promotion_media_type varchar(32), 
	ad_type varchar(32), 
	display_type varchar(32),
	coupon_type varchar(32), 
	ad_media_name varchar(32), 
	display_provider varchar(128), 
	promotion_cost integer,
	promotion_begin_date date, 
	promotion_end_date date ) 
DISTRIBUTED BY (promotion_key);

create table date_dimension
(	date_key                integer         not null primary key,
	date                    date,
	full_date_description   varchar(18),
	day_of_week             varchar(9),
	day_number_in_calendar_month    integer,
	day_number_in_calendar_year     integer,
	day_number_in_fiscal_month      integer,
	day_number_in_fiscal_year       integer,
	last_day_in_week_indicator      integer,
	last_day_in_month_indicator     integer,
	calendar_week_number_in_year    integer,
	calendar_month_name     varchar(9),
	calendar_month_number_in_year   integer,
	calendar_year_month     char(7),
	calendar_quarter        integer,
	calendar_year_quarter   char(7),
	calendar_half_year      integer,
	calendar_year           integer,
	holiday_indicator       varchar(10),
	weekday_indicator       char(7),
	selling_season          varchar(32)
) DISTRIBUTED BY (date_key);

create table vendor_dimension
(	vendor_key              integer         not null primary key,
	vendor_name             varchar(64),
	vendor_address          varchar(64),
	vendor_city             varchar(64),
	vendor_state            char(2),
	vendor_region           varchar(32),
	deal_size               integer,
	last_deal_update        date
) DISTRIBUTED BY (vendor_key);

create table employee_dimension
(	employee_key            integer         not null primary key,
	employee_gender         varchar(8),
	courtesy_title          varchar(8),
	employee_first_name     varchar(64),
	employee_middle_initial varchar(8),
	employee_last_name      varchar(64),
	employee_age            integer,
	hire_date               date,
	employee_street_address varchar(256),
	employee_city           varchar(64),
	employee_state          char(2),
	employee_region         char(32),
	job_title               varchar(64),
	reports_to              integer,
	salaried_flag           integer,
	annual_salary           integer,
	hourly_rate             float,
	vacation_days           integer
) DISTRIBUTED BY (employee_key);

create table shipping_dimension
(	shipping_key            integer         not null primary key,
	ship_type               char(30),
	ship_mode               char(10),
	ship_carrier            char(20)
) DISTRIBUTED BY (shipping_key);

create table warehouse_dimension
(	warehouse_key           integer         not null primary key,
	warehouse_name          varchar(20),
	warehouse_address       varchar(256),
	warehouse_city          varchar(60),
	warehouse_state         char(2),
        warehouse_region        varchar(32)
) DISTRIBUTED BY (warehouse_key);

create table inventory_fact
(	date_key                integer         not null,
	product_key             integer         not null,
	product_version         integer         not null,
	warehouse_key           integer         not null,
	qty_in_stock            integer
)
WITH (appendonly=true, orientation=column, compresstype=zlib,compresslevel=3)
DISTRIBUTED randomly;
--   DISTRIBUTED BY (date_key,product_key,product_version,warehouse_key);

-- alter table inventory_fact
--         add constraint fk_inventory_date foreign key (date_key)
--             references date_dimension (date_key),
--         add constraint fk_inventory_product foreign key (product_key,product_version)
--             references product_dimension (product_key,product_version),
--         add constraint fk_inventory_warehouse foreign key (warehouse_key)
--             references warehouse_dimension (warehouse_key);


create table store.store_dimension
(	store_key               integer         not null primary key,
	store_name              varchar(64),
	store_number            integer,
	store_address           varchar(256),
	store_city              varchar(64),
	store_state             char(2),
	store_region            varchar(64),
	floor_plan_type         varchar(32),
	photo_processing_type   varchar(32),
	financial_service_type  varchar(32),
	selling_square_footage  integer,
	total_square_footage    integer,
	first_open_date         date,
	last_remodel_date       date,
	number_of_employees     integer,
	annual_shrinkage        integer,
	foot_traffic            integer,
	monthly_rent_cost       integer
) DISTRIBUTED BY (store_key);

create table store.store_sales_fact
(	date_key                integer         not null,
	product_key             integer         not null,
	product_version         integer         not null,
	store_key               integer         not null,
	promotion_key           integer         not null,
	customer_key            integer         not null,
	employee_key            integer         not null,
	pos_transaction_number  bigint         not null,
	sales_quantity          integer,
	sales_dollar_amount     integer,
	cost_dollar_amount      integer,
	gross_profit_dollar_amount integer,
	transaction_type        varchar(16),
	transaction_time        time,
	tender_type             varchar(8)
) WITH (appendonly=true, orientation=column , compresstype=zlib,compresslevel=3)
DISTRIBUTED randomly;
--    DISTRIBUTED BY (date_key,product_key,product_version,store_key,promotion_key,customer_key,employee_key);

 
-- alter table store.store_sales_fact
--         add constraint fk_store_sales_date foreign key (date_key)
--             references public.date_dimension (date_key),
--         add constraint fk_store_sales_product foreign key (product_key,product_version)
--             references public.product_dimension (product_key,product_version),
--         add constraint fk_store_sales_store foreign key (store_key)
--             references store.store_dimension (store_key),
--         add constraint fk_store_sales_promotion foreign key (promotion_key)
--             references public.promotion_dimension (promotion_key),
--         add constraint fk_store_sales_customer foreign key (customer_key)
--             references public.customer_dimension (customer_key),
--         add constraint fk_store_sales_employee foreign key (employee_key)
--             references public.employee_dimension (employee_key);

create table store.store_orders_fact
(	product_key             integer         not null,
	product_version         integer         not null,
	store_key               integer         not null,
	vendor_key              integer         not null,
	employee_key            integer         not null,
	order_number            integer         not null,
	date_ordered            date,
	date_shipped            date,
	expected_delivery_date  date,
	date_delivered          date,
	quantity_ordered        integer,
	quantity_delivered      integer,
	shipper_name            varchar(32),
	unit_price              integer,
	shipping_cost           integer,
	total_order_cost        integer,
	quantity_in_stock       integer,
	reorder_level           integer,
	overstock_ceiling       integer
)
WITH (appendonly=true, orientation=column , compresstype=zlib,compresslevel=3)
DISTRIBUTED randomly;
--   DISTRIBUTED BY (product_key,product_version,store_key,vendor_key,employee_key,order_number);


-- alter table store.store_orders_fact
--         add constraint fk_store_orders_product foreign key (product_key,product_version)
--             references public.product_dimension (product_key,product_version),
--         add constraint fk_store_orders_store foreign key (store_key)
--             references store.store_dimension (store_key),
--         add constraint fk_store_orders_vendor foreign key (vendor_key)
--             references public.vendor_dimension (vendor_key),
--         add constraint fk_store_orders_employee foreign key (employee_key)
--             references public.employee_dimension (employee_key);



create table online_sales.online_page_dimension
(	online_page_key         integer         not null primary key,
	start_date              date,
	end_date                date,
	page_number             integer,
	page_description        varchar(100),
	page_type               varchar(100)
) DISTRIBUTED BY (online_page_key);

create table online_sales.call_center_dimension
(	call_center_key         integer         not null primary key,
	cc_closed_date          date,
	cc_open_date            date,
	cc_name                 varchar(50),
	cc_class                varchar(50),
	cc_employees            integer,
	cc_hours                char(20),
	cc_manager              varchar(40),
	cc_address              varchar(256),
	cc_city                 varchar(64),
	cc_state                char(2),
	cc_region               varchar(64) 
)DISTRIBUTED BY (call_center_key);

create table online_sales.online_sales_fact
(	sale_date_key           integer         not null,
	ship_date_key           integer         not null,
	product_key             integer         not null,
	product_version         integer         not null,
	customer_key            integer         not null,
	call_center_key         integer         not null,
	online_page_key         integer         not null,
	shipping_key            integer         not null,
	warehouse_key           integer         not null,
	promotion_key           integer         not null,
	pos_transaction_number  integer         not null,
	sales_quantity          integer,
	sales_dollar_amount     float,
	ship_dollar_amount      float,
	net_dollar_amount       float,
	cost_dollar_amount      float,
	gross_profit_dollar_amount float,
	transaction_type        varchar(16)
) WITH (appendonly=true, orientation=column ,  compresstype=zlib,compresslevel=3)
DISTRIBUTED randomly;
--    DISTRIBUTED BY (sale_date_key,ship_date_key,product_key,product_version,customer_key,call_center_key,online_page_key,
--	shipping_key,warehouse_key,promotion_key);


-- alter table online_sales.online_sales_fact
-- 	add constraint fk_online_sales_saledate foreign key (sale_date_key)
-- 	    references public.date_dimension (date_key),
--         add constraint fk_online_sales_shipdate foreign key (ship_date_key)
--             references public.date_dimension (date_key),
--         add constraint fk_online_sales_product foreign key (product_key,product_version)
--             references public.product_dimension (product_key,product_version),
--         add constraint fk_online_sales_customer foreign key (customer_key)
--             references public.customer_dimension (customer_key),
--         add constraint fk_online_sales_cc foreign key (call_center_key)
--             references online_sales.call_center_dimension (call_center_key),
--         add constraint fk_online_sales_op foreign key (online_page_key)
--             references online_sales.online_page_dimension (online_page_key),
--         add constraint fk_online_sales_shipping foreign key (shipping_key)
--             references public.shipping_dimension (shipping_key),
--         add constraint fk_online_sales_warehouse foreign key (warehouse_key)
--             references public.warehouse_dimension (warehouse_key),
--         add constraint fk_online_sales_promotion foreign key (promotion_key)
--             references public.promotion_dimension (promotion_key);


