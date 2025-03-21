-- Set execution mode
SET default_parallel 2;

-- Load CSV data from HDFS
orders = LOAD '/user/maria_dev/input/ecommerce_data.csv'
    USING PigStorage(',')
    AS (customer_id:chararray, name:chararray, email:chararray, address:chararray, phone:chararray, payment_method:chararray,
        order_id:chararray, order_details:chararray, quantity:int, total_amount:double,
        product_id:chararray, product_name:chararray, category:chararray, description:chararray);

-- Store data into HBase
STORE orders INTO 'hbase://My_Ecommerce:orders'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
        'Customer_Info:Name Customer_Info:Email Customer_Info:Address Customer_Info:Phone Customer_Info:PaymentMethod
         Order_Details:OrderID Order_Details:Details Order_Details:Quantity Order_Details:TotalAmount
         Product_Info:ProductID Product_Info:ProductName Product_Info:Category Product_Info:Description');
