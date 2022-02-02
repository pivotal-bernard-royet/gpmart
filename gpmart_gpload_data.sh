export data_directory=$1
export database=$2

gpload -d $database -f Call_Center_Dimension.gpload.yml
gpload -d $database -f Customer_Dimension.gpload.yml
gpload -d $database -f Date_Dimension.gpload.yml
gpload -d $database -f Date_Dimension.tbl.gpload.yml
gpload -d $database -f Employee_Dimension.gpload.yml
gpload -d $database -f Inventory_Fact.gpload.yml
gpload -d $database -f Online_Sales_Fact.gpload.yml
gpload -d $database -f Product_Dimension.gpload.yml
gpload -d $database -f Promotion_Dimension.gpload.yml
gpload -d $database -f Shipping_Dimension.gpload.yml
gpload -d $database -f Store_Dimension.gpload.yml
gpload -d $database -f Store_Orders_Fact.gpload.yml
gpload -d $database -f Store_Sales_Fact.gpload.yml
gpload -d $database -f Vendor_Dimension.gpload.yml
gpload -d $database -f Warehouse_Dimension.gpload.yml
