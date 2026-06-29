/*

Stored Procedure: Ladda bronslager från källa till brons

Syfte:
Denna lagrade procedur laddar data till 'brons'-schemat från CSV-filer.
Den utför följande åtgärder:
- Trunkerar bronstabellerna innan data laddas.
- Använder kommandot `BULK INSERT` för att ladda data från csv-filer till bronstabeller.

*/

CREATE OR ALTER  PROCEDURE brons.load_brons AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Laddar brons lager';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Laddar CRM tabeller';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: brons.crm_channel';
		TRUNCATE TABLE brons.crm_channel;
		PRINT '>> Infoga data i: brons.crm_channel';
		BULK INSERT brons.crm_channel
		FROM 'C:\sql\crm\channel.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
		PRINT '>> -------------';

	SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: brons.crm_cus_ser_iss';
	TRUNCATE TABLE brons.crm_cus_ser_iss;

	PRINT '>> Infoga data i: brons.crm_cus_ser_iss';
	BULK INSERT brons.crm_cus_ser_iss
	FROM 'C:\sql\crm\cus_ser_iss.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
	SET @end_time = GETDATE();
		PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
		PRINT '>> -------------';

	SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: brons.crm_con_per';
	TRUNCATE TABLE brons.crm_con_per;
	PRINT '>> Infoga data i: brons.crm_con_per';
	BULK INSERT brons.crm_con_per
	FROM 'C:\sql\crm\con_per.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
	PRINT '>> -------------';

	PRINT '------------------------------------------------';
	PRINT 'Laddar ERP Tabeller';
	PRINT '------------------------------------------------';
		
	SET @start_time = GETDATE();
	PRINT '>> Trunkering av tabell: brons.erp_cp_dest';
	TRUNCATE TABLE brons.erp_cp_dest;
	PRINT '>> Infoga data i: brons.erp_cp_dest';
	BULK INSERT brons.erp_cp_dest
	FROM 'C:\sql\erp\cp_dest.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
	SET @end_time = GETDATE();
		PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: brons.erp_cust_info';
	TRUNCATE TABLE brons.erp_cust_info;

	PRINT '>> Infoga data i: brons.erp_cust_info';
	BULK INSERT brons.erp_cust_info
	FROM 'C:\sql\crm\cust_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
	SET @end_time = GETDATE();
		PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
		PRINT '>> -------------';

				SET @start_time = GETDATE();
		PRINT '>> Trunkering av tabell: brons.erp_ship_id';
	TRUNCATE TABLE brons.erp_ship_id;

	PRINT '>> Infoga data i: brons.erp_ship_id';
	BULK INSERT brons.erp_ship_id
	FROM 'C:\sql\crm\ship_id.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ';',
		TABLOCK
	);
	SET @end_time = GETDATE();
		PRINT '>> Laddningslängd: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' sekunder';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Laddningen av bronslagret är klar';
    PRINT '   - Total laddningstid: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' sekunder';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'FEL UPPSTOD VID LADNING AV BRONSLAGRET'
		PRINT 'Felmeddelande' + ERROR_MESSAGE();
		PRINT 'Felmeddelande' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Felmeddelande' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
