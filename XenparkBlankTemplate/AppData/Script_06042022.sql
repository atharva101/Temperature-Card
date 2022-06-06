
/****** Object:  StoredProcedure [dbo].[sprocDeleteMaster]    Script Date: 6/4/2022 6:23:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[sprocDeleteMaster]        
@Type   VARCHAR(50),        
@Id  INT = 0,
@Allowed BIT = 1 OUT          
AS        
BEGIN 

BEGIN TRAN txDelete
BEGIN TRY
SET @Allowed = 1

IF(@Type = 'plant')        
 BEGIN        
	 DELETE FROM Plant WHERE Id = @Id  
 END        
 IF(@Type = 'block')        
 BEGIN        
	
	 DELETE FROM Block WHERE Id = @Id 
        
 END        
 IF(@Type = 'area')        
 BEGIN        
	
	DELETE a FROM Area a WHERE a.Id = @Id     
 END        
 IF(@Type = 'room')        
 BEGIN 
 
	DELETE FROM UserRoom WHERE RoomId = @Id
    
	DELETE rl FROM RoomLog rl 
	INNER JOIN Room r ON r.Id = rl.RoomId
	WHERE r.Id = @Id

	DELETE r FROM Room r WHERE r.Id = @Id    
 END       
 IF(@Type = 'product')        
 BEGIN        
       DELETE FROM mylan_ProductMaster WHERE Id = @Id
 END     
 IF(@Type = 'uom')        
 BEGIN        
   
   DELETE FROM mylan_UnitOfMeasure WHERE Id = @Id     
 END

 IF(@Type = 'user')        
 BEGIN        
   DELETE FROM RoomLog WHERE UserId = @Id
   DELETE FROM LoginInfo WHERE UserId = @Id
   DELETE FROM [User] WHERE Id = @Id
 END 
 
 IF(@Type = 'batch')        
 BEGIN        
   UPDATE RoomLog
   SET BatchId = NULL,
   BatchSize = NULL,
   TimeStamp = NULL,
   UserId = NULL 
   WHERE BatchId = @Id
   
   DELETE FROM Batch WHERE Id = @Id
   
 END 

 IF(@Type = 'role')        
 BEGIN        
   DELETE FROM RolePermission WHERE RoleId = @Id
   DELETE FROM [role] WHERE Id = @Id
   
 END 
 COMMIT TRAN txDelete
END TRY 
BEGIN CATCH 
	ROLLBACK TRAN txDelete
	SET @Allowed= 0 
	RAISERROR ( 'Delete failed',1,1) 
END CATCH  
        
return @Allowed
END

GO 

ALTER Procedure [dbo].[sprocAssignBatchToRoom]  
@BatchId INT,  
@RoomId INT,  
@UserId  INT  
AS     
BEGIN  
  DECLARE @WFStatus INT  
  SELECT TOP 1 @WFStatus = Id From dbo.StatusWorkFlow Where [ProductProcessing] = 1   
    
  DECLARE @BatchSize INT  
  DECLARE @UOM INT  
  SELECT @BatchSize = BatchSize, @UOM = P.UOM  FROM Batch B  
  INNER JOIN mylan_ProductMaster P ON P.Id = B.ProductId WHERE B.Id = @BatchId  
  
  UPDATE  dbo.RoomLog  
  SET StatusId = @WFStatus,   
  [TimeStamp] = GETDATE(),  
  BatchId = @BatchId,  
  [BatchSize] = @BatchSize,  
  UserId = @UserId,
  UOM = @UOM
  WHERE RoomId = @RoomId  
  
END
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 6/4/2022 5:36:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
     
   
     
ALTER Procedure [dbo].[sprocGetRoomStatus]                    
@RoomId INT  = -1                  
AS                    
BEGIN                    
                   
CREATE TABLE #Rooms                    
(                    
  RoomId   int,      
  RoomCode       varchar(200),      
  RoomDesc   varchar(200),      
  ProductId      int,      
  ProductCode  varchar(200),      
  ProductDesc  varchar(2000),      
  BatchId   int,      
  BatchNumber    varchar(200),      
  BatchSize      int,  
  UOM            VARCHAR(50),  
  RoomStatusId   int,      
  RoomCurrentStatus     varchar(200),      
  RoomStatusOrder int,      
  [TimeStamp]  DATETIME,    
  Plant varchar(200),    
  Block varchar(200) ,    
  Area varchar(200),  
  ReferenceNumber varchar(200),  
  FormNumber varchar(200),  
  VersionNumber varchar(200),  
)              
     
CREATE TABLE #RoomLog                  
(                  
  RoomId   int,    
  RoomStatusId   int,    
  RoomStatus     varchar(200),    
  RoomStatusOrder int  ,    
  [TimeStamp]  DATETIME,
   BatchId     INT,
   [BatchSize]  INT,
   UOM          VARCHAR(200),
   UserName     VARCHAR(200)
)    
     
INSERT INTO #Rooms (RoomId      
  ,RoomCode      
  ,RoomDesc    
  ,Plant    
  ,Block    
  ,Area  
  ,FormNumber  
  ,ReferenceNumber  
  ,VersionNumber)      
  SELECT R.Id,R.Code,R.Description, P.PlantName,    
  B.Code + (CASE WHEN ISNULL(B.Description, '') <> '' THEN '-' ELSE '' END) + B.Description,    
  A.Code + (CASE WHEN ISNULL(A.Description, '') <> '' THEN '-' ELSE '' END) + A.Description,  
  B.FormNumber,  
  B.ReferenceNumber,  
  B.VersionNumber    
  FROM Room R    
  INNER JOIN Area A ON A.Id = R.AreaId    
  INNER JOIN Block B ON B.Id = A.BlockId    
  INNER JOIN Plant P ON P.Id = B.PlantId    
  WHERE R.Id = CASE WHEN @RoomId > 0 THEN @RoomId ELSE R.Id END    
  AND R.Approved = 1    
   
UPDATE TR  SET    
TR.RoomStatusId = RL.StatusId,      
TR.RoomCurrentStatus = SWF.[Status],    
TR.RoomStatusOrder = SWF.[Order],    
TR.[TimeStamp] = RL.[TimeStamp]      
FROM #Rooms TR    
INNER JOIN dbo.RoomLog RL ON RL.RoomId = TR.RoomId            
INNER JOIN dbo.StatusWorkFlow SWF ON SWF.Id = RL.StatusId
 
-----------------------TODO
UPDATE temp      
SET ProductId  =  B.ProductId        
  ,ProductCode =  P.Code        
  ,ProductDesc = P.Description      
  ,BatchId    = B.Id      
  ,BatchNumber = B.BatchNumber        
  ,BatchSize  = RL.BatchSize  
  ,UOM = uom.Description  
FROM #Rooms temp
INNER JOIN RoomLog RL ON temp.RoomId = RL.RoomId 
INNER JOIN dbo.Batch B On B.Id = RL.BatchId      
INNER JOIN dbo.mylan_ProductMaster P ON P.Id = B.ProductId  
LEFT JOIN mylan_UnitOfMeasure uom ON uom.Id = RL.UOM  
INNER JOIN dbo.StatusWorkFlow W ON W.Id = temp.RoomStatusId    
                                    AND (W.ProductProcessing = 1)    
  
-----------------------TODO
     
   
INSERT INTO #RoomLog (    
   RoomId      
  ,RoomStatusId    
  ,RoomStatus        
  ,RoomStatusOrder   
  )    
Select R.RoomId, SWF.Id, SWF.Status, SWF.[Order] FROM #Rooms R    
CROSS JOIN StatusWorkFlow SWF

--DECLARE @AssignedBatchId INT  
--SELECT TOP 1 @AssignedBatchId = rl.BatchId FROM RoomLog rl
--INNER JOIN #Rooms r ON r.RoomId = rl.RoomId order by Id desc 
   
UPDATE tempRL    
SET tempRL.[TimeStamp] = RL.TimeStamp,    
    tempRL.UserName = U.FirstName + ' '+ U.LastName    
FROM #RoomLog tempRL    
INNER JOIN dbo.RoomLog RL ON RL.RoomId = tempRL.RoomId AND RL.StatusId = tempRL.RoomStatusId 
INNER JOIN [User] U ON U.Id = RL.UserId    
   
     
SELECT * FROM #Rooms R ORDER BY RoomId asc, [TimeStamp] desc    
SELECT * FROM #RoomLog ORDER BY RoomId, RoomStatusOrder      
     
DROP Table #Rooms                    
DROP Table #RoomLog                
               
END      

GO
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 6/4/2022 5:28:44 PM ******/
GO
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 6/6/2022 5:02:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[sprocChangeRoomStatus]
@RoomId INT,
@BatchId INT,
@BatchSize INT,
@UOM VARCHAR(500),
@StatusId INT,
@UserId INT
AS
BEGIN

DECLARE @RoomCurrentStatusId  int;
DECLARE @UOMId INT

SELECT TOP 1 @UOMId = Id FROM mylan_UnitOfMeasure WHERE [Description] = @UOM

-- This code is for Batch Completed in that case StatusID will be -1 
IF @StatusId = -1 
BEGIN
	SELECT @StatusId = Id FROM StatusWorkFlow WHERE [Order] = 1 

	UPDATE dbo.RoomLog
	SET 
	StatusId = @StatusId,
	[TimeStamp] = NULL,
	UserId = NULL,
	BatchId = NULL,
	[BatchSize] = NULL,
	[UOM] = NULL
	WHERE RoomId = @RoomId 
	RETURN 
END

IF (@BatchId <= 0) 
SET @BatchId = NULL

select TOP 1 @RoomCurrentStatusId = StatusId  FROM RoomLog WHERE RoomId = @RoomId ORDER BY Id DESC;

-- Update Room Log 
UPDATE dbo.RoomLog
SET StatusId = @StatusId,
[TimeStamp] = GETDATE(),
UserId = @UserId
WHERE RoomId = @RoomId
AND @StatusId <> @RoomCurrentStatusId

UPDATE dbo.RoomLog
SET 
BatchId = @BatchId,
[BatchSize] = @BatchSize,
[UOM] = @UOMId
WHERE RoomId = @RoomId
AND @StatusId <> @RoomCurrentStatusId
AND ISNULL(BatchId, 0) < 1 


---- Create a record in RoomLog
--INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp], BatchId, [BatchSize], UOM, UserId)
--SELECT  @RoomId, @StatusId, GETDATE(), @BatchId, @BatchSize, @UOMId, @UserId
--WHERE @StatusId <> @RoomCurrentStatusId

END

GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 6/4/2022 5:22:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
            
ALTER Procedure [dbo].[sprocAddEditMaster]            
@Id          INT,            
@Code        VARCHAR(100),            
@Description VARCHAR(2000),        
@Column1     VARCHAR(50),          
@Column2     VARCHAR(50),          
@Column3     VARCHAR(50),          
@ParentId    INT,            
@Type        VARCHAR(50),            
@ReturnValue   INT OUTPUT             
AS            
BEGIN            
  SET @ReturnValue = -101            
  DECLARE @PlantId INT;  
  DECLARE @MaxId INT    
      
  IF(ISNULL(@Id,0) < 1)            
  BEGIN            
   IF(@Type = 'product')            
   BEGIN       
     IF NOT EXISTS(SELECT 'x' FROM [mylan_ProductMaster] WHERE code = @Code)            
     BEGIN            
       INSERT INTO [mylan_ProductMaster] (Code, Description,Approved, UOM)            
       VALUES (@Code, @Description, 1, @ParentId)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = 'plant')            
   BEGIN            
     SELECT TOP 1 @MaxId = Id From Area Order By Id desc                 
     IF NOT EXISTS(SELECT 'x' FROM [Plant] WHERE PlantName = @Code AND Location = @Description)            
     BEGIN            
       INSERT INTO [Plant] (PlantName, Location, Approved)            
       VALUES (@Code, @Description, 0)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = 'block')            
   BEGIN  
     SELECT TOP 1 @MaxId = Id From Area Order By Id desc   
     IF NOT EXISTS(SELECT 'x' FROM [Block] WHERE Description = @Description AND PlantId = @ParentId)            
     BEGIN            
       INSERT INTO [Block] (Code, Description,ReferenceNumber,FormNumber,VersionNumber, PlantId, Approved)            
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description,@Column1,@Column2,@Column3, @ParentId, 1)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = 'area')            
   BEGIN   
     SELECT TOP 1 @MaxId = Id From Area Order By Id desc   
     SELECt @PlantId = PlantId FROM Block WHERE Id = @ParentId;            
     IF NOT EXISTS(SELECT 'x' FROM [Area] A            
           INNER JOIN [Block] B ON A.BlockId = B.Id            
           INNER JOIN Plant P ON P.Id = B.PlantId WHERE A.Description = @Description AND P.Id = @PlantId) -- Unique in Plant            
     BEGIN            
       INSERT INTO [Area] (Code, Description, BlockId, Approved)            
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description, @ParentId, 1)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = 'room')            
   BEGIN   
	 IF EXISTS (SELECT 1 FROM Room WHERE DeviceIPAddress = @Column1 AND @Column1 <> '')
	 BEGIN
			SET @ReturnValue = -102
			return 
	 END          
     IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId AND (@Column1 = '' OR DeviceIPAddress = @Column1))             
     BEGIN            
       INSERT INTO [Room] (Code, Description, AreaId, Status, Approved, DeviceIPAddress)           
       VALUES (@Code, @Description, @ParentId,null, 1, @Column1) 

	   DECLARE @RoomID INT,
	   @StatusID INT

	   SELECT @RoomID = SCOPE_IDENTITY() 
	   SELECT @StatusID = Id FROM StatusWorkFlow WHERE [Order] = 1
	   
	   INSERT INTO RoomLog (RoomId,StatusId)
	   VALUES (@RoomID,@StatusID)
		           
       SET @ReturnValue = 101            
     END            
   END           
   IF(@Type = 'uom')            
   BEGIN            
     IF NOT EXISTS(SELECT 'x' FROM [mylan_UnitOfMeasure] WHERE Description = @Description)             
     BEGIN      
       
    SELECT TOP 1 @MaxId = Id From mylan_UnitOfMeasure Order By Id desc     
       INSERT INTO [mylan_UnitOfMeasure] (Code, Description, Approved)            
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description,  1)            
       SET @ReturnValue = 101            
     END            
   END            
   END            
   ELSE            
   BEGIN            
    IF(@Type = 'product')            
     BEGIN            
       IF NOT EXISTS(SELECT 'x' FROM [mylan_ProductMaster] WHERE code = @Code AND Id <> @Id)            
       BEGIN            
         UPDATE X SET Code = @Code,            
                    [Description] = @Description,     
     [UOM] = @ParentId,    
                    Approved = 1       
         FROM [mylan_ProductMaster] X            
         WHERE Id= @Id           
         SET @ReturnValue = 101            
       END            
                   
     END            
     IF(@Type = 'plant')            
     BEGIN            
       IF NOT EXISTS(SELECT 'x' FROM [Plant] WHERE PlantName = @Code AND Location = @Description AND Id <> @Id)            
       BEGIN            
         UPDATE X SET PlantName = @Code,            
                      [Location] = @Description,           
                      Approved = 1            
         FROM [Plant] X            
         WHERE Id= @Id            
         SET @ReturnValue = 101            
       END            
     END            
     IF(@Type = 'block')            
     BEGIN            
       IF NOT EXISTS(SELECT 'x' FROM [Block] WHERE Description = @Description  AND PlantId = @ParentId AND Id <> @Id)            
       BEGIN            
         UPDATE X SET Code = @Code,            
                      [Description] = @Description,       
                      ReferenceNumber = @Column1,      
                      FormNumber = @Column2,      
                      VersionNumber = @Column3,      
                      plantId = @ParentId,            
                      Approved = 1           
         FROM [Block] X            
         WHERE Id= @Id            
         SET @ReturnValue = 101            
       END            
     END            
     IF(@Type = 'area')            
     BEGIN            
                   
       SELECt @PlantId = PlantId FROM Block WHERE Id = @ParentId;            
       IF NOT EXISTS(SELECT 'x' FROM [Area] A            
           INNER JOIN [Block] B ON A.BlockId = B.Id            
           INNER JOIN Plant P ON P.Id = B.PlantId WHERE A.[Description] = @Description AND P.Id = @PlantId AND A.Id <> @Id) -- Unique in Plant            
       BEGIN            
         UPDATE X SET               
               Code = @Code,            
               [Description] = @Description,            
               BlockId = @ParentId,            
              Approved = 1           
         FROM [Area] X            
         WHERE Id= @Id            
         SET @ReturnValue = 101            
       END            
     END            
     IF(@Type = 'room')            
     BEGIN  
	   IF EXISTS (SELECT 1 FROM Room WHERE DeviceIPAddress = @Column1 AND @Column1 <> '')
	   BEGIN
				SET @ReturnValue = -102
				return 
	   END            
       IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId AND Id <> @Id AND (@Column1 = '' OR DeviceIPAddress = @Column1))            
       BEGIN            
         UPDATE X SET   Code = @Code,            
             [Description] = @Description,            
             AreaId = @ParentId,            
            Approved = 1,  
			DeviceIPAddress = @Column1            
         FROM [Room] X            
         WHERE Id= @Id      
         SET @ReturnValue = 101            
       END                   
     END           
  IF(@Type = 'uom')            
     BEGIN            
       IF NOT EXISTS(SELECT 'x' FROM [mylan_UnitOfMeasure] WHERE [Description] = @Description AND Id <> @Id)            
       BEGIN            
         UPDATE X SET [Description] = @Description,          
            Approved = 1            
         FROM [mylan_UnitOfMeasure] X            
         WHERE Id= @Id            
         SET @ReturnValue = 101            
       END                   
     END           
   END            
   RETURN @ReturnValue            
END 
GO       

Update StatusWorkFlow
set ProductProcessing = 1 
WHERE [Status] = 'Maintenance'

GO