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

Alter table public.products_inventory add foreign key (supplier_id) references public.suppliers(id);



insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('knife',100,'weapon',100,100 *1.20,true,'Sofia');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Bomb',2,'weapon',250,250 *1.20,true,'Kazanluk');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('AK-47',500,'weapon',4500,4500*1.20,true,'Kazanluk');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Mercedes',0,'car',50000,50000*1.20,false,'Plovdiv');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Volvo',5,'car',40000,40000*1.20,true,'Sofia');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('LG-TV',20,'TV',1000,1000*1.20,true,'Burgas');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Samsung-TV',0,'TV',500,500*1.20,false,'Burgas');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Iphone',10000,'Smart phone',2000,2000*1.20,true,'Sofia');

insert into products_inventory (product_name,quantity,product_type,price_without_vat,price_with_vat,is_product_in_stock,warehouse) 
values ('Xiomi',400,'Smart phone',500,500*1.20,true,'Plovdiv');

--Get the count of all available products in stock
select count(quantity)
from products_inventory pi2 
where quantity > 0;


--Get the average product price with VAT for all categories
select product_type , AVG(price_with_vat)
from products_inventory pi2 
group by product_type ;

--Get the total amount of all available items in stock (use price with VAT and available qty.)
select sum(price_with_vat)
from products_inventory pi2 
where quantity > 0;

--Find the most and least expensive item from the table
select min(price_with_vat), max(price_with_vat)
from products_inventory pi2 ;

--Find the most expensive item in each warehouse
select max(price_with_vat), warehouse
from products_inventory pi2 
group by warehouse ;

--Get the count of all products for each category
select count(id),product_type
from products_inventory pi2 
group by product_type ;

--Get the count of all products for each category in and out of stock
select count(id),product_type
from products_inventory pi2 
where is_product_in_stock = true 
group by product_type ;

select count(id),product_type
from products_inventory pi2 
where is_product_in_stock = false 
group by product_type ;

--Get the count of all products for each category where the products count is more than 3
select count(id), product_type
from products_inventory pi2 
group by product_type 
having count(id) >= 3;

--Get the inventory amount for each warehouse
select sum(quantity), warehouse
from products_inventory pi2 
group by warehouse ;

--Get all product categories stored by each warehouse
select count(distinct product_type) as product_categories ,warehouse 
from products_inventory pi2 
group by warehouse ;

--Get the avarage product categories hold by the warehouses
SELECT warehouse, cast(avg(quantity) as integer) as avg_quantity
FROM public.products_inventory
WHERE is_product_in_stock IS TRUE
GROUP BY warehouse
ORDER BY warehouse asc;
