/*
=============================================================
Stored Procedure: Load Bronze Layer (Source --> Bronze)
=============================================================
Script Purpose:
    End‑to‑end Bronze layer ingestion: truncates target 
    tables, bulk loads CRM/ERP CSV sources, logs durations,
    and handles errors.
=============================================================
*/


EXEC bronze.load_bronze;

GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    BEGIN TRY
    DECLARE @start_time DATETIME, @end_time DATETIME, @overall_start DATETIME, @overall_end DATETIME;
        SET @overall_start = GETDATE();
        PRINT '====================================================';
        PRINT 'Loading Bronze Layer...';
        PRINT '====================================================';

        PRINT '----------------------------------------------------';
        PRINT 'Loading CRM Tables...';
        PRINT '----------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info

        PRINT '>>> Loading Rows to Table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info

        PRINT '>>> Loading Rows to Table: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details

        PRINT '>>> Loading Rows to Table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();   
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';

        PRINT '----------------------------------------------------';
        PRINT 'Loading ERP Tables...';
        PRINT '----------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12

        PRINT '>>> Loading Rows to Table: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();   
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101

        PRINT '>>> Loading Rows to Table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();   
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';

        SET @start_time = GETDATE();
        PRINT '>>> Truncate Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2

        PRINT '>>> Loading Rows to Table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\mamok\OneDrive\Documents\Data\data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();   
        PRINT '>>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>> ---------------------------------- <<<';
        SET @overall_end = GETDATE();
        PRINT '====================================================';
        PRINT 'Bronze Layer Load Summary';
        PRINT '====================================================';

        PRINT '>>> CRM Tables Loaded:';
        PRINT '    - bronze.crm_cust_info';
        PRINT '    - bronze.crm_prd_info';
        PRINT '    - bronze.crm_sales_details';

        PRINT '>>> ERP Tables Loaded:';
        PRINT '    - bronze.erp_cust_az12';
        PRINT '    - bronze.erp_loc_a101';
        PRINT '    - bronze.erp_px_cat_g1v2';

        PRINT '----------------------------------------------------';
        PRINT '>>> Total Runtime: ' 
              + CAST(DATEDIFF(second, @overall_start, @overall_end) AS NVARCHAR)
              + ' seconds';
        PRINT '----------------------------------------------------';

        PRINT '====================================================';
        PRINT 'Bronze Layer Load Completed Successfully';
        PRINT '====================================================';

    END TRY
    BEGIN CATCH
        PRINT '===============================================';
        PRINT 'ERROR OCCURRED DURING LOADING OF BRONZE LAYER';
        PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
        PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===============================================';
    END CATCH
END
