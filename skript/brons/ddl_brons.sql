/*
DDL-skript: Skapa bronstabeller

Syfte:
Det här skriptet skapar tabeller i 'brons'-schemat och tar bort befintliga tabeller om de redan finns.
Kör det här skriptet för att omdefiniera DDL-strukturen för 'brons'-tabeller.

*/

IF OBJECT_ID ('brons.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE brons.crm_cust_info;
GO

CREATE TABLE brons.crm_cust_info(
	cust_id INT,
	comp_nm NVARCHAR(50),
	country NVARCHAR(50),
	segment NVARCHAR(50),
	sector NVARCHAR(50),
	status NVARCHAR(50),
	cre_dt DATE
);
GO

IF OBJECT_ID ('brons.crm_channel' , 'U') IS NOT NULL
	DROP TABLE brons.crm_channel;
CREATE TABLE brons.crm_channel(
	cha_id NVARCHAR(50),
	cha_nm NVARCHAR(50)
);
GO

IF OBJECT_ID ('brons.crm_cus_ser_iss' , 'U') IS NOT NULL
	DROP TABLE brons.crm_cus_ser_iss;
CREATE TABLE brons.crm_cus_ser_iss(
	case_id NVARCHAR(50),
	ship_id NVARCHAR(50),
	cust_id INT,
	item_id NVARCHAR(50),
	chan_id NVARCHAR(50),
	open_date DATETIME2,
	closed_date DATETIME2,
	status NVARCHAR(50),
	deli_prob INT,
	invoice_q INT,
	c_m INT,
	complaints INT
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
	item_id NVARCHAR(50),
	deli_sta NVARCHAR(50),
	delivery_date DATE
);
GO
