
--Create tables

create table customers (
	Id SERIAL primary key,
    Profile_name varchar(255) not null,
    Email varchar(255) not null unique,
    Phone VARCHAR(20) not null unique,
    Age int default '99',
    Gdpr_consent boolean not null,
    Is_customer_profile_active boolean not null,
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
    Is_customer_profile_active boolean not null,
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

-- Import data in tables

--Add records in customer_addresses table
insert into customer_addresses (address,city,province,postal_code,country) values 
('Mladost 1','Sofia','Sofia',1000,'Bulgaria'),
('Mladost 2','Sofia','Sofia',1000,'Bulgaria'),
('Lulin5','Sofia','Sofia',5000,'Bulgaria'),
('Lulin10','Sofia','Sofia',6000,'Bulgaria'),
('Chaika','Varna','Varna',1500,'Bulgaria'),
('Morska Gara','Varna','Varna',1600,'Bulgaria'),
('Slaveikov','Burgas','Burgas',5500,'Bulgaria'),
('Izgrev','Burgas','Burgas',5600,'Bulgaria'),
('Diana','Yambol','Yambol',8600,'Bulgaria'),
('Graf Ignatiev','Yambol','Yambol',8600,'Bulgaria'),
('Georgi Benkovski','Plovdiv','Plovdiv',7700,'Bulgaria'),
('Hale','Stara Zagora','Stara Zagora',2000,'Bulgaria'),
('Zornica','Stara Zagora','Stara Zagora',2000,'Bulgaria');

--Add some records for USA address
insert into customer_addresses (address,city,state,postal_code,country) values 
('Street 1','Washington','Washington',8900,'USA'),
('Street 2','Los Angeles','LA',9900,'USA'),
('Street 3','New York','Pensilvania',8900,'USA'),
('Street 4','Las Vegas','Nevada',9500,'USA'),
('Street 5','Atlantic City','Ohio',9700,'USA');


--add records in customers table
insert into customers(Profile_name,Email,Phone,Age,Gdpr_consent,is_custumer_profile_active,address_id) values 
('Georgi','georgi.raychev@abv.bg','0889345678',22,true,true,1),
('user2','testuser2@abv.bg','0811111113',33,true,true,1),
('user3','testuser3@abv.bg','0881233432',22,true,true,3),
('user4','testuser4@abv.bg','0884534231',22,true,true,4),
('user5','testuser5@abv.bg','0889142356',22,true,true,5),
('user6','testuser6@abv.bg','0811122235',22,true,true,6),
('user7','testuser7@abv.bg','0888865444',22,true,true,7),
('user8','testuser8@abv.bg','0880091813',22,true,true,8),
('user9','testuser9@abv.bg','0880099812',22,true,true,9),
('user10','testuser10@abv.bg','08897234857',22,true,true,10),
('user11','testuser11@abv.bg','08893154512',22,true,true,11),
('user12','testuser12@abv.bg','08800998822',22,true,true,12),
('user13','testuser13@abv.bg','08988822331',22,true,true,13);

--add records in orders table
insert into orders (customer_id,is_order_completed,is_order_payed,date_order_completed) values 
(4,true,true,CURRENT_TIMESTAMP),
(4,true,true,CURRENT_TIMESTAMP),
(5,true,true,CURRENT_TIMESTAMP),
(5,true,true,CURRENT_TIMESTAMP),
(6,false,false,null),
(6,true,false,null),
(1,false,false,null),
(1,false,false,null),
(2,true,true,CURRENT_TIMESTAMP),
(8,true,true,CURRENT_TIMESTAMP);

--add records in suppliers table
insert into suppliers_addresses (adress,city,province,postal_code,country) values 
('Mladost 1','Sofia','Sofia',1000,'Bulgaria'),
('Mladost 2','Sofia','Sofia',1000,'Bulgaria'),
('Lulin5','Sofia','Sofia',5000,'Bulgaria'),
('Lulin10','Sofia','Sofia',6000,'Bulgaria'),
('Chaika','Varna','Varna',1500,'Bulgaria'),
('Morska Gara','Varna','Varna',1600,'Bulgaria'),
('Slaveikov','Burgas','Burgas',5500,'Bulgaria'),
('Izgrev','Burgas','Burgas',5600,'Bulgaria'),
('Diana','Yambol','Yambol',8600,'Bulgaria'),
('Graf Ignatiev','Yambol','Yambol',8600,'Bulgaria'),
('Georgi Benkovski','Plovdiv','Plovdiv',7700,'Bulgaria'),
('Hale','Stara Zagora','Stara Zagora',2000,'Bulgaria'),
('Zornica','Stara Zagora','Stara Zagora',2000,'Bulgaria');

--Add some records for USA address
insert into suppliers_addresses (adress,city,state,postal_code,country) values 
('Street 1','Washington','Washington',8900,'USA'),
('Street 2','Los Angeles','LA',9900,'USA'),
('Street 3','New York','Pensilvania',8900,'USA'),
('Street 4','Las Vegas','Nevada',9500,'USA'),
('Street 5','Atlantic City','Ohio',9700,'USA');

--add records in supliers table 
insert into suppliers (profile_name,email,phone,age,gdpr_consent,is_custumer_profile_active,address_id) values 
('supplier1','supplier1@gmail.com',08888882,88,true,true,1),
('supplier2','supplier2@gmail.com',08888881,77,true,true,3),
('supplier3','supplier3@gmail.com',088882388,66,true,true,4),
('supplier4','supplier4@gmail.com',08888128,55,true,true,5),
('supplier5','supplier5@gmail.com',08888568,44,true,true,6),
('supplier6','supplier6@gmail.com',088881238,33,true,true,8),
('supplier7','supplier7@gmail.com',0865788888,22,true,true,9),
('supplier8','supplier8@gmail.com',08812888,11,true,true,11),
('supplier9','supplier9@gmail.com',08884488,15,true,true,12),
('supplier10','supplier10@gmail.com',08889987,89,true,true,13),
('supplier11','supplier11@gmail.com',08885588,67,true,true,16),
('supplier12','supplier12@gmail.com',08881188,45,true,true,17),
('supplier13','supplier13@gmail.com',08882288,45,true,true,18);


--add records in product_inventory
insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse,supplier_id)
values 
('prod1',3,'weapon',100,100*1.2,true,'Sofia',3),
('prod2',0,'weapon',10,10*1.2,false,'Sofia',5),
('prod3',0,'car',20,20*1.2,false,'Sofia',5),
('prod4',4,'car',300,300*1.2,true,'Sofia',6),
('prod5',5,'car',250,250*1.2,true,'Sofia',6),
('prod6',7,'food',555,555*1.2,true,'Sofia',3),
('prod7',6,'food',1000,1000*1.2,true,'Sofia',7),
('prod8',8,'food',10,10*1.2,true,'Sofia',7),
('prod9',9,'food',50,50*1.2,true,'Sofia',11),
('prod10',10,'Bomb',2550,2550*1.2,true,'Sofia',11),
('prod11',20,'Bomb',333,333*1.2,true,'Sofia',11),
('prod12',100,'weapon',222,222*1.2,true,'Sofia',12),
('prod13',25,'phone',654,654*1.2,true,'Sofia',12),
('prod14',33,'phone',777,777*1.2,true,'Sofia',1),
('prod15',44,'Tv',1000,1000*1.2,true,'Sofia',1);

--add records in order_product_quantities
insert into orders_product_quantities (product_id,orders_id,quantity) values 
(1,1,3),
(1,1,4),
(2,2,2),
(2,2,4),
(4,2,1),
(4,3,5),
(6,3,2),
(6,3,6),
(7,4,7),
(8,5,2);

--Create views
--customers_contact_info: all customers contact information - phone, address and etc.
create view customers_contact_info as 
select profile_name,email,phone ,address ,city ,province , postal_code , country
from public.customers c 
inner join public.customer_addresses ca 
on c.address_id = ca.address_id ;

--customers_active_orders: customer id, name and phone with order id, status and date of ordering
create view customer_active_orders as
select customer_id ,profile_name , phone , o.id as order_id ,is_order_completed, is_order_payed, date_of_order, date_order_completed
from public.customers c
inner join public.orders o 
on c.id = o.customer_id 
where is_order_completed is true;

--customers_pending_payments: customer id and name with list of pending orders that are not payed, order date and total sum expected to be payed.
create view customers_pending_payments as
select public.customers.id as customer_id,public.customers.profile_name ,public.orders.id as order_id , sum(public.products_inventory.price_with_vat*public.products_inventory.quantity) as total_amount, public.orders.date_of_order
from public.products_inventory pi2 
inner join public.orders_product_quantities opq 
on pi2.id = opq.product_id 
inner join public.orders o 
on opq.orders_id = o.id 
inner join public.customers c 
on o.customer_id = c.id 
where o.is_order_payed is false 
group by customer_id , profile_name , order_id , date_of_order;

--supplier_inventory: supplier id, name and phone with available products (qty > 0), quantity, price with and without VAT and the warehouse the item is located
create view supplier_inventory as
select supplier_id , profile_name, phone ,quantity , price_with_vat , price_without_vat, warehouse
from suppliers s 
inner join public.products_inventory pi 
on s.id = pi.supplier_id
where quantity > 0 ;


--customer_ordered_items: customer id and name with ordered product and product type
create view customer_ordered_items as
select customer_id , profile_name , product_name , product_type
from products_inventory pi
inner join orders_product_quantities opq 
on pi.id = opq.product_id 
inner join orders o 
on opq.orders_id = o.id 
inner join customers c 
on o.customer_id = c.id ;

--phones: a union of all suppliers and customers ids, names and phone numbers
create view custumers_and_suppliers_union as
select id , profile_name , phone
from customers c 
union 
select id , profile_name , phone 
from suppliers s 
group by profile_name ,id;

--list of customers whos phone number is listed as phone number of another customer
select c.id as customer_one_id , c.profile_name as customer_one_name, c.phone as customer_one_phone , c2.id as second_customer_id , c2.profile_name as second_customer_name, c2.phone as second_customer_phone
from customers c , customers c2
where c.phone = c2.phone 
and c.id <> c2.id;

--using left and right joins, find customers without orders and orders without active customers
--find customers without orders
select distinct  c.id , c.profile_name 
from customers c 
left join orders o 
on c.id = o.customer_id 
where o.customer_id is null
order by c.id ;

--orders without active customers
select c.id ,c.profile_name 
from customers c 
right join orders o
on c.id = o.customer_id 
where c.is_custumer_profile_active is false
order by c.id;

--using full join, find customers without orders and orders without active customers
--find customers without orders
select distinct *
from customers c 
full join orders o 
on c.id = o.customer_id 
where o.customer_id is null ;

--orders without active customers
select *
from customers c 
full join orders o 
on c.id = o.customer_id 
where c.is_custumer_profile_active is false ;


	
