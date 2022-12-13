
CREATE PROCEDURE [ClearTempTable]
(
	@StoreId INT,
	@TempTableName NVARCHAR(30),
	@Dobs NVARCHAR(300)
)

AS

BEGIN
	DECLARE	@DBName NVARCHAR(128),
			@ErrorMessage NVARCHAR(4000),
			@Proc NVARCHAR(50),
			@StoreIdColumnName NVARCHAR(50),
			@DobColumnName nvarchar(30),
			@SQL NVARCHAR(1000)

	SET @Proc = ISNULL(OBJECT_NAME(@@PROCID), 'Null Proc')

	SELECT @DBName = DB_NAME()
								   			
	BEGIN TRY
	 BEGIN transaction
		IF (LOWER(@TempTableName) = 'temp_intmsgdt')
			BEGIN
				SET @StoreIdColumnName = 'StoreId'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_intmsg')
			BEGIN
				SET @StoreIdColumnName = 'StoreId'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_hstgndotherwages')
			BEGIN
				SET @StoreIdColumnName = 'StoreId'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_hstwageedit')
			BEGIN
				SET @StoreIdColumnName = 'StoreId'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_hstgndintmsg')
			BEGIN
				SET @StoreIdColumnName = 'StoreId'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_hstgeneralledgeractivity')
			BEGIN
				SET @StoreIdColumnName = 'UnitNumber'
				SET @DobColumnName = 'BatchDate'
			END
		ELSE IF (LOWER(@TempTableName) = 'temp_hstschedule')
				BEGIN
					SET @DobColumnName = 'ScheduleDate'
				END
		ELSE
			BEGIN
				SET @StoreIdColumnName = 'FKStoreId'
				SET @DobColumnName = 'DateOfBusiness'
			END

		SET @SQL = 'DELETE FROM [' + @TempTableName + '] WHERE [' + @StoreIdColumnName + '] = ' + CAST(@StoreId AS NVARCHAR(20)) +
					' AND [' + @DobColumnName + '] IN (' + @Dobs  + ')'
		EXEC (@SQL)
		commit transaction
	END TRY
    BEGIN CATCH
        if(ERROR_NUMBER()=1205)
        begin
        select 'Dealock occured.Wait for 5 seconds.'
        waitfor delay '00:00:10'
        end
        SET @ErrorMessage = @Proc + ': Error: ' + ISNULL(ERROR_MESSAGE(), 'Null Error')   
        RAISERROR (@ErrorMessage, 16, 1);
        rollback transaction
    END CATCH
END
GO
