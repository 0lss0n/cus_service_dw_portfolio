/*

DDL-skript: Skapa silver tabell

Syfte:
Detta skript skapar tabeller i 'silver'-schemat och tar bort befintliga tabeller om de redan finns.
Kör detta skript för att omdefiniera DDL-strukturen för 'silver'-tabeller.

*/

IF OBJECT_ID ('silver.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info(
	cust_id INT,
	comp_nm NVARCHAR(50),
	country NVARCHAR(50),
	segment NVARCHAR(50),
	sector NVARCHAR(50),
	status NVARCHAR(50),
	cre_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.crm_channel' , 'U') IS NOT NULL
	DROP TABLE silver.crm_channel;
CREATE TABLE silver.crm_channel(
	cha_id NVARCHAR(50),
	cha_nm NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.crm_cus_ser_iss' , 'U') IS NOT NULL
	DROP TABLE silver.crm_cus_ser_iss;
CREATE TABLE silver.crm_cus_ser_iss(
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
	complaints INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_cp_dest' , 'U') IS NOT NULL
	DROP TABLE silver.erp_cp_dest;
CREATE TABLE silver.erp_cp_dest(
	ship_id NVARCHAR(50),
	cust_id INT,
	origin NVARCHAR(50),
	destination NVARCHAR(50),
	country NVARCHAR(50),
	item_id NVARCHAR(50),
	deli_sta NVARCHAR(50),
	delivery_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
