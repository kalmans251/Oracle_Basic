DROP TABLE "tb_zipcode";

CREATE TABLE "tb_zipcode" (
	"zipcode"	varchar2(7)		NOT NULL,
	"sido"	varchar2(30)		NULL,
	"gugun"	varchar2(30)		NULL,
	"dong"	varchar2(30)		NULL,
	"bungi"	varchar2(30)		NULL
);

DROP TABLE "member";

CREATE TABLE "member" (
	"id"	varchar2(20)		NOT NULL,
	"pwd"	varchar2(20)		NULL,
	"name"	varchar2(50)		NULL,
	"address"	varchar2(20)		NULL,
	"tel"	varchar2(13)		NULL,
	"indate"	date		NULL,
	"zipcode"	varchar2(7)		NOT NULL
);

DROP TABLE "products";

CREATE TABLE "products" (
	"product_code"	varchar2(20)		NOT NULL,
	"product_name"	varchar2(100)		NULL,
	"product_kind"	char(1)		NULL,
	"product_price1"	varchar(10)		NULL,
	"product_price2"	varchar2(10)		NULL,
	"product_content"	varchar2(1000)		NULL,
	"product_image"	varchar2(50)		NULL,
	"sizeSt"	varchar2(5)		NULL,
	"sizeEt"	varchar2(5)		NULL,
	"product_quantity"	varchar2(5)		NULL,
	"useyn"	char(1)		NULL,
	"indate"	date		NULL
);

DROP TABLE "orders";

CREATE TABLE "orders" (
	"o_seq"	number(10)		NOT NULL,
	"product_size"	varchar2(5)		NULL,
	"quantity"	varchar2(5)		NULL,
	"result"	char(1)		NULL,
	"indate"	date		NULL,
	"product_code"	varchar2(20)		NOT NULL,
	"id"	varchar2(20)		NOT NULL
);

ALTER TABLE "tb_zipcode" ADD CONSTRAINT "PK_TB_ZIPCODE" PRIMARY KEY (
	"zipcode"
);

ALTER TABLE "member" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"id"
);

ALTER TABLE "products" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY (
	"product_code"
);

ALTER TABLE "orders" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"o_seq"
);

ALTER TABLE "member" ADD CONSTRAINT "FK_tb_zipcode_TO_member_1" FOREIGN KEY (
	"zipcode"
)
REFERENCES "tb_zipcode" (
	"zipcode"
);

ALTER TABLE "orders" ADD CONSTRAINT "FK_products_TO_orders_1" FOREIGN KEY (
	"product_code"
)
REFERENCES "products" (
	"product_code"
);

ALTER TABLE "orders" ADD CONSTRAINT "FK_member_TO_orders_1" FOREIGN KEY (
	"id"
)
REFERENCES "member" (
	"id"
);

