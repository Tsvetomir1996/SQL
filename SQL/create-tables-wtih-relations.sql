

--Create tables

create table customers (
	Id SERIAL primary key,
    Profile_name varchar(255) not null,
    Email varchar(255) not null unique,
    Phone VARCHAR(20) not null unique,
    Age int default '99',
    Gdpr_consent boolean not null,
    Is_custumer_profile_active boolean not null,
    Profile_created_at TIMESTAMP default CURRENT_TIMESTAMP,
    Profile_deactivated TIMESTAMP,
    Reason_for_deactivation varchar(255),
    Notes varchar(2500)
);

Alter table public.customers ADD column address_id int not null ;

create table customer_addresses (
	Address_id serial primary key ,
	Address varchar(255) ,
	City   varchar(100) not null ,
	Province varchar(100) ,
	State varchar(100) ,
	Postal_code int check(Postal_code>=0) not null ,
	Country varchar(255) not null
);

create table products_inventory(
	id SERIAL primary key,
	Product_name varchar(255) not null ,
	Quantity int not null ,
	Product_type varchar(255) not null ,
	Price_without_vat int not null ,
	Price_with_vat int not null ,
	Is_product_in_stock BOOLEAN not null ,
	Warehouse varchar(255) not null 
) ;

Alter table public.products_inventory add column supplier_id int;


create table suppliers (
	Id SERIAL primary key,
    Profile_name varchar(255) not null,
    Email varchar(255) not null unique,
    Phone VARCHAR(20) not null unique,
    Age int default '99',
    Gdpr_consent boolean not null,
    Is_custumer_profile_active boolean not null,
    Profile_created_at TIMESTAMP default CURRENT_TIMESTAMP,
    Profile_deactivated TIMESTAMP,
    Reason_for_deactivation varchar(255),
    Notes varchar(2500)
);

ALTER TABLE public.suppliers ADD COLUMN address_id INT UNIQUE NOT NULL;

create table suppliers_addresses (
	id serial primary key,
	Adress varchar(255) ,
	City   varchar(100) not null ,
	Province varchar(100) ,
	State varchar(100) ,
	Postal_code int check(Postal_code>=0) not null ,
	Country varchar(255) not null
);

create table orders (
	Id SERIAL primary key,
	customer_id int not null,
	Is_order_completed boolean not null,
	Is_order_payed boolean not null,
	Date_of_order TIMESTAMP default CURRENT_TIMESTAMP,
	Date_order_completed TIMESTAMP
);

create table orders_product_quantities (
    id serial primary key,
    product_id int not null,
    orders_id int not null,
    quantity int not null
);

--Create relations between tables

--1:1 relationship between customers and customers_addresses tables
Alter table public.customers ADD foreign key (address_id) references public.customer_addresses (address_id);

--1:1 relationship between suppliers and suppliers_addresses tables
Alter table public.suppliers add foreign key (address_id) references public.suppliers_addresses(id);

--1: many  relationship between customers and orders
Alter table public.orders ADD foreign key (customer_id) references public.customers (id) on delete cascade;

--1: many relationship between suppliers and products_inventory
Alter table public.products_inventory add foreign key (supplier_id) references public.suppliers(id) on delete cascade;

--many:many relationship between orders and products_inventory table with the ordered quantity
Alter table public.orders_product_quantities add FOREIGN KEY(product_id) references public.products_inventory(id) on delete cascade;

Alter table public.orders_product_quantities add FOREIGN KEY(orders_id) references public.orders(id) on delete cascade;
