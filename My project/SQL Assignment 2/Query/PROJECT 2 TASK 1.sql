-- 1. Describe the data in hand in your own words.

1. cust_dimen: Details of all the customers
		
        Customer_Name (TEXT): Name of the customer
        Province (TEXT): Province of the customer
        Region (TEXT): Region of the customer
        Customer_Segment (TEXT): Segment of the customer
        Cust_id (TEXT): Unique Customer ID
	
    2. market_fact: Details of every order item sold
		
        Ord_id (TEXT): Order ID
        Prod_id (TEXT): Prod ID
        Ship_id (TEXT): Shipment ID
        Cust_id (TEXT): Customer ID
        Sales (DOUBLE): Sales from the Item sold
        Discount (DOUBLE): Discount on the Item sold
        Order_Quantity (INT): Order Quantity of the Item sold
        Profit (DOUBLE): Profit from the Item sold
        Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        Product_Base_Margin (DOUBLE): Product Base Margin on the Item sold
        
    3. orders_dimen: Details of every order placed
		
        Order_ID (INT): Order ID
        Order_Date (TEXT): Order Date
        Order_Priority (TEXT): Priority of the Order
        Ord_id (TEXT): Unique Order ID
	
    4. prod_dimen: Details of product category and sub category
		
        Product_Category (TEXT): Product Category
        Product_Sub_Category (TEXT): Product Sub Category
        Prod_id (TEXT): Unique Product ID
	
    5. shipping_dimen: Details of shipping of orders
		
        Order_ID (INT): Order ID
        Ship_Mode (TEXT): Shipping Mode
        Ship_Date (TEXT): Shipping Date
        Ship_id (TEXT): Unique Shipment ID


2. Identify and list the Primary Keys and Foreign Keys for this dataset provided to
you(In case you don’t find either primary or foreign key, then specially mention this in your answer)  

	1. cust_dimen
       PRIMARY_KEY: Cust_id, 
	   FOREIGN_KEY: NA
	
    2. market_fact
		PRIMARY_KEY: NA
        FOREIGN_KEY: Ord_id, Prod_id, Ship_id, Cust_id
	
    3. orders_dimen
		PRIMARY_KEY: Ord_id
		FOREIGN_KEY: NA
	
    4. prod_dimen
		PRIMARY_KEY: Prod_id, Product_Sub_Category
        FOREIGN_KEY: NA
	
    5. shipping_dimen
		PRIMARY_KEY: Ship_id
        FOREIGN_KEY: NA

