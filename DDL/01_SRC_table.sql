
-- 1. CUSTOMERS
CREATE TABLE SRC.customers (
    customer_id               VARCHAR(50)  NOT NULL,
    customer_unique_id        VARCHAR(50),
    customer_zip_code_prefix  VARCHAR(10),   -- VARCHAR, not INT, to keep leading zeros
    customer_city             VARCHAR(100),
    customer_state            VARCHAR(5),
    CONSTRAINT pk_src_customers PRIMARY KEY (customer_id)
);

-- 2. ORDERS
CREATE TABLE SRC.orders (
    order_id                       VARCHAR(50) NOT NULL,
    customer_id                    VARCHAR(50),
    order_status                   VARCHAR(20),
    order_purchase_timestamp       TIMESTAMP,
    order_approved_at              TIMESTAMP,
    order_delivered_carrier_date   TIMESTAMP,
    order_delivered_customer_date  TIMESTAMP,
    order_estimated_delivery_date  TIMESTAMP,
    CONSTRAINT pk_src_orders PRIMARY KEY (order_id)
);

-- 3. ORDER_ITEMS
CREATE TABLE SRC.order_items (
    order_id             VARCHAR(50) NOT NULL,
    order_item_id        INTEGER     NOT NULL,
    product_id           VARCHAR(50),
    seller_id            VARCHAR(50),
    shipping_limit_date  TIMESTAMP,
    price                NUMERIC(10,2),
    freight_value        NUMERIC(10,2),
    CONSTRAINT pk_src_order_items PRIMARY KEY (order_id, order_item_id)
);

-- 4. ORDER_PAYMENTS
CREATE TABLE SRC.order_payments (
    order_id              VARCHAR(50) NOT NULL,
    payment_sequential    INTEGER     NOT NULL,
    payment_type          VARCHAR(30),
    payment_installments  INTEGER,
    payment_value         NUMERIC(10,2),
    CONSTRAINT pk_src_order_payments PRIMARY KEY (order_id, payment_sequential)
);

select * from order_payments