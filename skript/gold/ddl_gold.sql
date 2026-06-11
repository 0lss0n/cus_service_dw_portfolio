/*
DDL skript: skapa guld Views.

Syfte:
Detta skript skapar Views för det sista lagret i datalagret.
Guld lagret representerar de slutliga dimensionerna och faktatabellerna. Varje vy använder data från silverlagret för att skapa en ren,
berikad och affärsklar datauppsättning.
Man kan ställa frågor till dessa vyer direkt för analys och rapportering.
*/

-- Skapa dimension: guld.dim_checkpoint_destination

IF OBJECT_ID('guld.dim_checkpoint_destination', 'V') IS NOT NULL
    DROP VIEW guld.dim_checkpoint_destination;
GO

CREATE VIEW guld.dim_checkpoint_destination AS
  SELECT
  ship_id AS shipment_id,
  cust_id AS customer_id,
  origin,
  destination,
  country,
  item_id,
  deli_sta AS delivery_status,
  delivery_date
  FROM silver.erp_cp_dest
GO

--Skapa dimension: guld.dim_customer_info

IF OBJECT_ID('guld.dim_customer_info', 'V') IS NOT NULL
    DROP VIEW guld.dim_customer_info;
GO

CREATE VIEW guld.dim_customer_info AS
  SELECT
  cust_id AS customer_id,
  comp_nm AS company_name,
  country,
  segment,
  sector,
  status,
  cre_dt AS create_date
  FROM silver.crm_cust_info
GO

--Skapa dimension guld.dim_channel

IF OBJECT_ID('guld.dim_channel', 'V') IS NOT NULL
    DROP VIEW guld.dim_channel;
GO

CREATE VIEW guld.dim_channel AS
  SELECT
  cha_id AS channel_id,
  cha_nm AS channel_name
  FROM silver.crm_channel

--Skapa fakta tabell: guld.fact_customer_serivce_issues

IF OBJECT_ID('guld.fact_customer_serivce_issues', 'V') IS NOT NULL
    DROP VIEW guld.fact_customer_serivce_issues;
GO

CREATE VIEW guld.fact_customer_serivce_issues AS
  SELECT
  case_id,
  ship_id AS shipment_id,
  cust_id AS customer_id,
  item_id,
  chan_id AS channel_id,
  open_date,
  closed_date,
  status,
  deli_prob AS delivery_problems,
  invoice_q AS invoice_questions,
  c_m AS customs_matters,
  complaints
  FROM silver.crm_cus_ser_iss
GO
