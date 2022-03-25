IF NOT EXISTS (SELECT 'x' FROM sys.columns
               WHERE object_id = object_id('RoomLog')
               AND   name = 'BatchId')
BEGIN
  ALTER TABLE RoomLog
	ADD BatchId INT

	ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_Batch_RoomLog_BatchId] FOREIGN KEY([BatchId])
	REFERENCES [dbo].[Batch] ([Id])
END
GO

IF NOT EXISTS (SELECT 'x' FROM sys.columns
               WHERE object_id = object_id('RoomLog')
               AND   name = 'BatchSize')
BEGIN
  ALTER TABLE RoomLog
	ADD [BatchSize] INT
END
GO


IF NOT EXISTS (SELECT 'x' FROM sys.columns
               WHERE object_id = object_id('RoomLog')
               AND   name = 'UOM')
BEGIN
  ALTER TABLE RoomLog
	ADD [UOM] INT 

  ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_mylan_UOM_RoomLog_UOM] FOREIGN KEY([UOM])
	REFERENCES [dbo].[mylan_UnitOfMeasure] ([Id])
END
GO
 
IF NOT EXISTS (SELECT 'x' FROM sys.columns
               WHERE object_id = object_id('RoomLog')
               AND   name = 'UserId')
BEGIN
  ALTER TABLE RoomLog
	ADD UserId INT

	ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_User_RoomLog_UserId] FOREIGN KEY([UserId])
	REFERENCES [dbo].[User] ([Id])
END

-----------------------DELETE ACTION ------------------------------------------------
USE [weavingplantdb]
GO
/****** Object:  StoredProcedure [dbo].[sprocDeleteMaster]    Script Date: 3/24/2022 10:31:33 PM ******/
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
   DELETE FROM RoomLog WHERE BatchId = @Id
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
USE [weavingplantdb]
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 3/25/2022 5:04:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[sprocGetMaster]        
@Type   VARCHAR(50),        
@ParentId  INT = 0,        
@ApproveOnly BIT = 0      
AS        
BEGIN  

CREATE TABLE #master (
Id                INT,
Code              VARCHAR(500),
[Description]	  VARCHAR(MAX),
ParentId          INT,
ParentCode		  VARCHAR(500),
ParentDescription VARCHAR(MAX),
Column1			  VARCHAR(MAX),
Column2			  VARCHAR(MAX),
Column3			  VARCHAR(MAX),
Approved		  BIT,
IsUsed			  BIT DEFAULT (0)
)      
        
 IF(@Type = 'plant')        
 BEGIN
 
INSERT INTO #master
   SELECT Id as Id,         
   PlantName as Code,        
   Location as Description,        
   ParentId = 0,        
   ParentCode = '',      
   ParentDescription = '',  
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(Approved,0) AS Approved,
   0     
   From Plant        
   WHERE Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE Approved END 
   
   UPDATE #master 
   SET IsUsed = 1
   WHERE EXISTS (SELECT 'X' FROM Block WHERE PlantId = #master.Id)  
      
 END        
 IF(@Type = 'block')        
 BEGIN   
 INSERT INTO #master     
   SELECT B.Id,         
   Code,        
   Description,        
   PlantId as ParentId,        
   PlantName AS ParentCode,      
   Location as ParentDescription ,    
   Column1= B.ReferenceNumber,  
   Column2= B.FormNumber,  
   Column3= B.VersionNumber,  
   ISNULL(B.Approved,0) AS Approved,
   0  
     
   From Block B         
   INNER JOIN Plant P on P.Id = B.PlantId        
   WHERE (@ParentId = 0 OR B.PlantId = @ParentId)       
   AND B.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE B.Approved END  
   
   UPDATE #master
   SET IsUsed = 1
   WHERE EXISTS (SELECT 'X' FROM Area WHERE BlockId = #master.Id) 
       
 END        
 IF(@Type = 'area')        
 BEGIN 
  INSERT INTO #master        
   SELECT A.Id,         
   A.Code,        
   A.Description,        
   A.BlockId as ParentId,        
   B.Code AS ParentCode,      
   B.Description as ParentDescription,  
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(A.Approved,0) AS Approved,
   0       
   From Area A        
   INNER JOIN Block B on B.Id = A.BlockId        
   WHERE (@ParentId = 0 OR A.BlockId = @ParentId)      
   AND A.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE A.Approved END   
   
   UPDATE #master
   SET IsUsed = 1
   WHERE EXISTS (SELECT 'X' FROM Room WHERE AreaId = #master.Id)   
 END        
 IF(@Type = 'room')        
 BEGIN 
   INSERT INTO #master        
   SELECT R.Id,         
   R.Code,        
   R.Description,        
   R.AreaId as ParentId,        
   A.Code AS ParentCode,      
   A.Description as ParentDescription ,  
   Column1=ISNULL(R.DeviceIPAddress, ''),  
   Column2='',  
   Column3='',  
   ISNULL(R.Approved,0) AS Approved,
   0      
   From Room R        
   INNER JOIN Area A on A.Id = R.AreaId        
   WHERE (@ParentId = 0 OR R.AreaId = @ParentId)         
   AND R.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE R.Approved END      
 END       
 IF(@Type = 'product')        
 BEGIN
   INSERT INTO #master         
   SELECT P.Id,         
   P.Code,        
   P.Description,        
   ISNULL(uom.Id,0) as ParentId,        
   uom.Code AS ParentCode,      
   uom.Description as ParentDescription ,    
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(P.Approved,0) AS Approved ,
   0     
   From mylan_ProductMaster P
   LEFT JOIN mylan_UnitOfMeasure uom ON p.UOM = uom.Id
   WHERE P.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE P.Approved END  
   
   UPDATE #master
   SET IsUsed = 1
   WHERE EXISTS (SELECT 'X' FROM Batch WHERE ProductId = #master.Id)    
 END     
 IF(@Type = 'uom')        
 BEGIN
   INSERT INTO #master         
   SELECT P.Id,         
   P.Code,        
   P.Description,        
   0 as ParentId,        
   '' AS ParentCode,      
   '' as ParentDescription ,    
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(P.Approved,0) AS Approved,
   0     
   From mylan_UnitOfMeasure P      
   WHERE P.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE P.Approved END 
   
   UPDATE #master
   SET IsUsed = 1
   WHERE EXISTS (SELECT 'X' FROM mylan_ProductMaster WHERE UOM = Id) 
   OR EXISTS (SELECT 'X' FROM RoomLog WHERE UOM = #master.Id)     
 END 
 SELECT * FROM #master    
END        








