/*
Stored Procedures: Ladda silverlager från bronslager till silverlager

Syfte:
Denna Stored Procedure utför ETL-processen för att fylla i 'silver' schematabellerna från 'brons'-schemat.
Utförda åtgärder:
- Trunkerar silver-tabeller.
- Infogar transformerade och rensade data från brons till silver tabeller.

*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Laddar silver lager';
        PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Laddar ERP Tabell';
		PRINT '------------------------------------------------';

		-- Laddar silver.erp_cp_dest
    SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: silver.erp_cp_dest';
		TRUNCATE TABLE silver.erp_cp_dest;
		PRINT '>> Infoga data i: silver.erp_cp_dest';

	INSERT INTO silver.erp_cp_dest(
		ship_id,
		cust_id,
		origin,
		destination,
		country,
		prod_id,
		d_status,
		d_date
		)
	SELECT
		ship_id,
		cust_id,
		origin,
		TRIM(destination) AS destination,
		country,
		prod_id,
		CASE WHEN UPPER(TRIM(d_status)) = 'd' THEN 'Delivered'
			 ELSE 'n/a'
		END d_status,
		d_date
		FROM brons.erp_cp_dest
	SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';

		-- Laddar silver.erp_cust_info
    SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: silver.erp_cust_info';
		TRUNCATE TABLE silver.erp_cust_info;
		PRINT '>> Infoga data i: silver.erp_cust_info';

	INSERT INTO silver.erp_cust_info(
		cust_id,
		comp_nm,
		country,
		segment,
		sector,
		status,
		cre_dt
		)
	SELECT
		cust_id,
		comp_nm,
		country,
		segment,
		sector,
		status,
		cre_dt
		d_date
		FROM brons.erp_cust_info
	SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';

		-- Laddar silver.erp_ship_id
    SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: silver.erp_ship_id';
		TRUNCATE TABLE silver.erp_ship_id;
		PRINT '>> Infoga data i: silver.erp_ship_id';

	INSERT INTO silver.erp_ship_id(
		ship_id,
		case_id,
		cust_id,
		prod_id,
		origin,
		destination,
		country,
		d_status,
		d_date,
		weight,
		volume
		)
	SELECT
		ship_id,
		case_id,
		cust_id,
		prod_id,
		origin,
		destination,
		country,
		d_status,
		d_date,
		weight,
		volume
		FROM brons.erp_ship_id
	SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';

		PRINT '------------------------------------------------';
		PRINT 'Laddar CRM Tabeller';
		PRINT '------------------------------------------------';

        -- Laddar silver.crm_cus_ser_iss
    SET @start_time = GETDATE();

		PRINT '>> Trunkering av tabell: silver.crm_cus_ser_iss';
		TRUNCATE TABLE silver.crm_cus_ser_iss;
		PRINT '>> Infoga data i: silver.crm_cus_ser_iss';
		INSERT INTO silver.crm_cus_ser_iss(
		case_id,
		ship_id,
		cust_id,
		prod_id,
		chan_id,
		open_date,
		closed_date,
		duration_minutes,
		status,
		csat,
		case_type
		)
	SELECT
		REPLACE(case_id, '-', '_') AS case_id,
		ship_id,
		cust_id,
		prod_id,
		chan_id,
		open_date,
		closed_date,
		DATEDIFF(MINUTE, open_date, closed_date),
		CASE WHEN UPPER(TRIM(status)) = 'c' THEN 'closed'
			 WHEN UPPER(TRIM(status)) = 'o' THEN 'open'
			 ELSE 'n/a'
		END status,
		csat,
		case_type
		FROM brons.crm_cus_ser_iss
	SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';

		--Laddar silver.crm_channel
	SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: silver.crm_channel';
		TRUNCATE TABLE silver.crm_channel;
		PRINT '>> Infoga data i: silver.crm_channel';
		INSERT INTO silver.crm_channel(
		chan_id,
		chan_nm
		)
	SELECT
		chan_id,
		chan_nm
		FROM brons.crm_channel
	 SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';
		
		--Laddar silver.crm_con_per
	SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: silver.crm_con_per';
		TRUNCATE TABLE silver.crm_con_per;
		PRINT '>> Infoga data i: silver.crm_con_per';

		INSERT INTO silver.crm_con_per(
		cont_id,
		cust_id,
		comp_nm,
		first_name,
		last_name,
		role,
		email,
		phone
		)
	SELECT
		cont_id,
		cust_id,
		comp_nm,
		first_name,
		last_name,
		role,
		email,
		phone
		FROM brons.crm_con_per
	SET @end_time = GETDATE();
        PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
        PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Inläsning av silver lager klart';
        PRINT '   - Total laddningstid: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' sekunder';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'FEL UPPSTOD VID LADDNING AV SILVERLAGRET'
		PRINT 'Error Meddelnade' + ERROR_MESSAGE();
		PRINT 'Error Meddelande' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Meddelande' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
