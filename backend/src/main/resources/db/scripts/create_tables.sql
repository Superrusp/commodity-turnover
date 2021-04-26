CREATE TABLE goods
(
    goods_id    NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name        VARCHAR2(50) NOT NULL,
    description VARCHAR2(250),
    price       NUMBER(6,2),

    CONSTRAINT goods_pk PRIMARY KEY (goods_id)
);

CREATE TABLE shops
(
    shop_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name    VARCHAR2(50) NOT NULL,

    CONSTRAINT shops_pk PRIMARY KEY (shop_id)
);

CREATE TABLE warehouses
(
    warehouse_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name         VARCHAR2(50) NOT NULL,

    CONSTRAINT warehouses_pk PRIMARY KEY (warehouse_id)
);

CREATE TABLE goods_in_stocks
(
    goods_in_stock_id  NUMBER GENERATED BY DEFAULT AS IDENTITY,
    goods_id           NUMBER NOT NULL,
    warehouse_id       NUMBER NOT NULL,
    available_quantity NUMBER(5) NOT NULL,

    CONSTRAINT goods_in_stocks_pk PRIMARY KEY (goods_in_stock_id),
    CONSTRAINT goods_fk           FOREIGN KEY(goods_id) REFERENCES goods(goods_id),
    CONSTRAINT warehouses_fk      FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE goods_in_shops
(
    goods_in_shop_id   NUMBER GENERATED BY DEFAULT AS IDENTITY,
    goods_id           NUMBER NOT NULL,
    shop_id            NUMBER NOT NULL,
    available_quantity NUMBER(5) NOT NULL,

    CONSTRAINT goods_in_shops_pk PRIMARY KEY (goods_in_shop_id),
    CONSTRAINT goods_in_shops_fk FOREIGN KEY(goods_id) REFERENCES goods(goods_id),
    CONSTRAINT shops_fk          FOREIGN KEY(shop_id) REFERENCES shops(shop_id)
);

CREATE TABLE delivery_requests
(
    delivery_request_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    shop_id             NUMBER,
    warehouse_id        NUMBER,
    request_date        DATE NOT NULL,
    arrival_date        DATE NOT NULL,

    CONSTRAINT delivery_requests_pk          PRIMARY KEY (delivery_request_id),
    CONSTRAINT delivery_requests_to_shops_fk FOREIGN KEY(shop_id) REFERENCES shops(shop_id),
    CONSTRAINT delivery_requests_to_wh_fk    FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id),
    CONSTRAINT customer_not_null_ck          CHECK ((shop_id is not null and warehouse_id is null)
        or (warehouse_id is not null and shop_id is null))
);

CREATE TABLE delivery_request_goods
(
    delivery_request_id NUMBER NOT NULL,
    goods_id NUMBER NOT NULL,

    CONSTRAINT delivery_request_goods_pk             PRIMARY KEY (delivery_request_id, goods_id),
    CONSTRAINT request_goods_to_delivery_requests_fk FOREIGN KEY(delivery_request_id) REFERENCES delivery_requests(delivery_request_id),
    CONSTRAINT delivery_request_goods_to_goods_fk    FOREIGN KEY(goods_id) REFERENCES goods(goods_id)
);

CREATE TABLE delivery_items
(
    delivery_item_id    NUMBER GENERATED BY DEFAULT AS IDENTITY,
    goods_id            NUMBER NOT NULL,
    delivery_request_id NUMBER NOT NULL,
    delivery_status     VARCHAR2(30) NOT NULL,

    CONSTRAINT delivery_items_pk          PRIMARY KEY (delivery_item_id),
    CONSTRAINT delivery_items_to_goods_fk FOREIGN KEY(goods_id) REFERENCES goods(goods_id),
    CONSTRAINT delivery_requests_fk       FOREIGN KEY(delivery_request_id) REFERENCES delivery_requests(delivery_request_id)
);