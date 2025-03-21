-- Set execution mode
SET default_parallel 2;

-- Load CSV data from HDFS
orders = LOAD '/user/maria_dev/input/ecommerce_data.csv'
    USING PigStorage(',')
    AS (customer_id:chararray, name:chararray, email:chararray, address:chararray, phone:chararray, payment_method:chararray,
        order_id:chararray, order_details:chararray, quantity:int, total_amount:double,
        product_id:chararray, product_name:chararray, category:chararray, description:chararray);

-- Store data into HBase table 'my-ecommerce'
STORE orders INTO 'hbase://my-ecommerce'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
        'customer_info:name customer_info:email customer_info:address customer_info:phone customer_info:payment_method
         order_details:order_id order_details:order_details order_details:quantity order_details:total_amount
         product_info:product_id product_info:product_name product_info:category product_info:description');
