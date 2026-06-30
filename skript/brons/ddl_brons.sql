/*
DDL-skript: Skapa bronstabeller

Syfte:
Det här skriptet skapar tabeller i 'brons'-schemat och tar bort befintliga tabeller om de redan finns.
Kör det här skriptet för att omdefiniera DDL-strukturen för 'brons'-tabeller.

*/

IF OBJECT_ID ('brons.crm_con_per' , 'U') IS NOT NULL
	DROP TABLE brons.crm_con_per;
GO

CREATE TABLE brons.crm_con_per(
	cont_id INT,
	cust_id INT,
	comp_nm NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	role NVARCHAR(50),
	email NVARCHAR(50),
	phone NVARCHAR(50)
);
GO

IF OBJECT_ID ('brons.crm_channel' , 'U') IS NOT NULL
	DROP TABLE brons.crm_channel;
CREATE TABLE brons.crm_channel(
	chan_id NVARCHAR(50),
	chan_nm NVARCHAR(50)
);
GO

IF OBJECT_ID ('brons.crm_cus_ser_iss' , 'U') IS NOT NULL
	DROP TABLE brons.crm_cus_ser_iss;
CREATE TABLE brons.crm_cus_ser_iss(
	case_id NVARCHAR(50),
	ship_id NVARCHAR(50),
	cust_id INT,
	prod_id NVARCHAR(50),
	chan_id NVARCHAR(50),
	open_date DATETIME2,
	closed_date DATETIME2,
	status NVARCHAR(50),
	csat INT,
	case_type NVARCHAR(50)
);
GO

IF OBJECT_ID ('brons.erp_cp_dest' , 'U') IS NOT NULL
	DROP TABLE brons.erp_cp_dest;
CREATE TABLE brons.erp_cp_dest(
	ship_id NVARCHAR(50),
	cust_id INT,
	origin NVARCHAR(50),
	destination NVARCHAR(50),
	country NVARCHAR(50),
	prod_id NVARCHAR(50),
	d_status NVARCHAR(50),
	d_date DATE
);
GO

IF OBJECT_ID ('brons.erp_cust_info' , 'U') IS NOT NULL
	DROP TABLE brons.erp_cust_info;
CREATE TABLE brons.erp_cust_info(
	cust_id INT,
	comp_nm NVARCHAR(50),
	country NVARCHAR(50),
	segment NVARCHAR(50),
	sector NVARCHAR(50),
	status NVARCHAR(50),
	cre_dt DATE
);
GO

IF OBJECT_ID ('brons.erp_ship_id' , 'U') IS NOT NULL
	DROP TABLE brons.erp_ship_id;
CREATE TABLE brons.erp_ship_id(
	ship_id NVARCHAR (50),
	case_id NVARCHAR (50),
	cust_id INT,
	prod_id NVARCHAR(50),
	origin NVARCHAR(50),
	destination NVARCHAR(50),
	country NVARCHAR(50),
	d_status NVARCHAR(50),
	d_date DATE,
	weight DECIMAL(6,3),
	volume DECIMAL(6,3)
);
GO
