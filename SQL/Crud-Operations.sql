create table customers (
	Id SERIAL primary key,
    Profile_name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Age INT default '99',
    Gdpr_consent BOOLEAN NOT NULL,
    Is_custumer_profile_active BOOLEAN NOT NULL,
    Profile_created_at TIMESTAMP default CURRENT_TIMESTAMP,
    Profile_deactivated TIMESTAMP,
    Reason_for_deactivation VARCHAR(255),
    Notes VARCHAR(2500)
);

create index idx_name on customers (Profile_name);  -- creating index for fast searching by name

create database orders_management ; --query for creating data base 

drop database orders_management ; --query for deleting data base 

drop table public.customers ; --query for deleting table

truncate table public.customers ; --query for deleting data from data table


--create cusutmer with all fields
insert into customers(Profile_name,Email,Phone,Age,Gdpr_consent,is_custumer_profile_active,profile_created_at,profile_deactivated,
reason_for_deactivation,notes) values 
('Tsvetomir,cvetomir_318@abv.bg','0897227535',22,true,true,CURRENT_TIMESTAMP,null,null,'Notes for the profile');

--create custumer only with mandatory fields
insert into customers (Profile_name,email,phone,gdpr_consent,is_custumer_profile_active,profile_created_at) values
('Ivan','ivan124@abv.bg','0988231243',true,true,CURRENT_TIMESTAMP);

-- retrieves only customer�s name and phone
select Profile_name, phone
from customers c 

-- retrieves only internal information about the user - GDPR status, profile status, date created, date deactivated,  reason for deactivation and the notes taken of the user
select Gdpr_consent,is_custumer_profile_active,profile_created_at,profile_deactivated,reason_for_deactivation,notes
from customers c 

--retrieving all customer info by customer id
select *
from customers c 
where id = 1;

--update customer by id - change contact phone 
update customers 
set phone = '0888667788'
where id = 1;

--update customer by id - deactivate accout
update customers 
set is_custumer_profile_active = false , profile_deactivated = current_timestamp , reason_for_deactivation = 'This is needed in the task'
where id = 1;

--update customer by id - activate accout
update customers 
set is_custumer_profile_active = true 
where id = 1;

--delete cutumomer by id
delete from customers 
where id = 1;
