create table customer_addresses (
Address_id serial primary key ,
Address varchar(255) ,
City   varchar(100) not null ,
Province varchar(100) ,
State varchar(100) ,
Postal_code int check(Postal_code>=0) not null ,
Country varchar(255) not null
);

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Boris Dimovski','Sofia','Sofia',null,1000,'Bulgaria');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('z.k Diana','Yambol','Yambol',null,8600,'Bulgaria');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('z.k Zornica','Burgas','Burgas',null,5600,'Bulgaria');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Stara Reka','Plovdid','Plovdiv',null,2500,'Bulgaria');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Morska gara 11','Varna','Varna',null , 4455,'Bulgaria');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Washington','Washington',null,'Woshington' , 1111,'USA');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Central','Paris','France',null,8600,'France');

insert into customer_addresses (Adress,City,Province,State,Postal_code,Country) 
values ('St.Shanzelize','Paris','France',null,3607,'France');

--Create a view bulgarian_customers_addresses which contains only addreses in Bulgaria;
create view bulgarian_customers_addresses as
select *
from customer_addresses ca 
where country = 'Bulgaria';

--get a list of countries ordered alphabetically
select distinct country
from customer_adress ca 
order by country  asc

--get a list of cities that start with a specific letter
select *
from customer_adress ca 
where city like 'S%';

--get 3 different random cities located in Bulgaria
select city
from customer_adress ca 
order by random()
limit 3

--get a list of all addresses in Bulgaria outside of Sofia, Plovdiv, Varna
select adress
from customer_adress ca 
where city not in ('Sofia','Plovdiv','Varna');

--get last 10 added customer addresses with a province and address filled, but without a state value
select *
from customer_adress as ca 
where ca.adress is not null AND ca.province is not null and ca.state is null
order by adress_id desc
limit 5;

--get addresses that have 4-digit postal code that start with 3 and end with 7. Order the result alpabetically by country and city
select adress , country , city , postal_code 
from customer_adress  
where "postal_code"::text like '3__7'
order by country asc , city asc; 
