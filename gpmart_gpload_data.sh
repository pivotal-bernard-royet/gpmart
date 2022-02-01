export data_directory=$1

gpload -d vmart -f Call_Center_Dimension.gpload.yml
gpload -d vmart -f Customer_Dimension.gpload.yml
gpload -d vmart -f Date_Dimension.gpload.yml
gpload -d vmart -f Date_Dimension.tbl.gpload.yml
gpload -d vmart -f Employee_Dimension.gpload.yml
gpload -d vmart -f Inventory_Fact.gpload.yml
gpload -d vmart -f Online_Sales_Fact.gpload.yml
gpload -d vmart -f Product_Dimension.gpload.yml
gpload -d vmart -f Promotion_Dimension.gpload.yml
gpload -d vmart -f Shipping_Dimension.gpload.yml
gpload -d vmart -f Store_Dimension.gpload.yml
gpload -d vmart -f Store_Orders_Fact.gpload.yml
gpload -d vmart -f Store_Sales_Fact.gpload.yml
gpload -d vmart -f Vendor_Dimension.gpload.yml
gpload -d vmart -f Warehouse_Dimension.gpload.yml
