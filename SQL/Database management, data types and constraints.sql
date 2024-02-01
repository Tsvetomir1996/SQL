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


Alter table public.customers ADD column address_id int not null ;

Alter table public.customers ADD foreign key (address_id) references public.customer_addresses (address_id);
