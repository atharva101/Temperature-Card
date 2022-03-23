USE [weavingplantdb]
GO

IF NOT EXISTS (SELECT 1
               FROM   INFORMATION_SCHEMA.COLUMNS
               WHERE  TABLE_NAME = 'ROOM'
                      AND COLUMN_NAME = 'DeviceIPAddress'
                      AND TABLE_SCHEMA='DBO')
  BEGIN
      ALTER TABLE ROOM 
		ADD DeviceIPAddress	varchar	(20)
  END
GO


/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 3/23/2022 12:02:02 PM ******/
DROP PROCEDURE [dbo].[sprocGetMaster]
GO

/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 3/23/2022 12:02:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sprocGetMaster]        
@Type   VARCHAR(50),        
@ParentId  INT = 0,        
@ApproveOnly BIT = 0      
AS        
BEGIN        
        
 IF(@Type = 'plant')        
 BEGIN        
   SELECT Id as Id,         
   PlantName as Code,        
   Location as Description,        
   ParentId = 0,        
   ParentCode = '',      
   ParentDescription = '',  
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(Approved,0) AS Approved      
   From Plant        
   WHERE Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE Approved END      
 END        
 IF(@Type = 'block')        
 BEGIN        
   SELECT B.Id,         
   Code,        
   Description,        
   PlantId as ParentId,        
   PlantName AS ParentCode,      
   Location as ParentDescription ,    
   Column1= B.ReferenceNumber,  
   Column2= B.FormNumber,  
   Column3= B.VersionNumber,  
   ISNULL(B.Approved,0) AS Approved   
     
   From Block B         
   INNER JOIN Plant P on P.Id = B.PlantId        
   WHERE (@ParentId = 0 OR B.PlantId = @ParentId)       
   AND B.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE B.Approved END      
 END        
 IF(@Type = 'area')        
 BEGIN        
   SELECT A.Id,         
   A.Code,        
   A.Description,        
   A.BlockId as ParentId,        
   B.Code AS ParentCode,      
   B.Description as ParentDescription,  
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(A.Approved,0) AS Approved        
   From Area A        
   INNER JOIN Block B on B.Id = A.BlockId        
   WHERE (@ParentId = 0 OR A.BlockId = @ParentId)      
   AND A.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE A.Approved END      
 END        
 IF(@Type = 'room')        
 BEGIN        
   SELECT R.Id,         
   R.Code,        
   R.Description,        
   R.AreaId as ParentId,        
   A.Code AS ParentCode,      
   A.Description as ParentDescription ,  
   Column1=ISNULL(R.DeviceIPAddress, ''),  
   Column2='',  
   Column3='',  
   ISNULL(R.Approved,0) AS Approved       
   From Room R        
   INNER JOIN Area A on A.Id = R.AreaId        
   WHERE (@ParentId = 0 OR R.AreaId = @ParentId)         
   AND R.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE R.Approved END      
 END       
 IF(@Type = 'product')        
 BEGIN        
   SELECT P.Id,         
   P.Code,        
   P.Description,        
   ISNULL(uom.Id,0) as ParentId,        
   uom.Code AS ParentCode,      
   uom.Description as ParentDescription ,    
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(P.Approved,0) AS Approved      
   From mylan_ProductMaster P
   LEFT JOIN mylan_UnitOfMeasure uom ON p.UOM = uom.Id
   WHERE P.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE P.Approved END      
 END     
 IF(@Type = 'uom')        
 BEGIN        
   SELECT P.Id,         
   P.Code,        
   P.Description,        
   0 as ParentId,        
   '' AS ParentCode,      
   '' as ParentDescription ,    
   Column1='',  
   Column2='',  
   Column3='',  
   ISNULL(P.Approved,0) AS Approved      
   From mylan_UnitOfMeasure P      
   WHERE P.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE P.Approved END      
 END     
END        


GO


/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 3/23/2022 12:04:01 PM ******/
DROP PROCEDURE [dbo].[sprocAddEditMaster]
GO

/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 3/23/2022 12:04:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

          
CREATE Procedure [dbo].[sprocAddEditMaster]          
@Id          INT,          
@Code        VARCHAR(100),          
@Description VARCHAR(50),      
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
       VALUES (@Code, @Description, 0, @ParentId)          
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
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description,@Column1,@Column2,@Column3, @ParentId, 0)          
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
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description, @ParentId, 0)          
       SET @ReturnValue = 101          
     END          
   END          
   IF(@Type = 'room')          
   BEGIN          
     IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId AND (@Column1 = '' OR DeviceIPAddress = @Column1))           
     BEGIN          
       INSERT INTO [Room] (Code, Description, AreaId, Status, Approved, DeviceIPAddress)          
       VALUES (@Code, @Description, @ParentId,null, 0, @Column1)          
       SET @ReturnValue = 101          
     END          
   END         
   IF(@Type = 'uom')          
   BEGIN          
     IF NOT EXISTS(SELECT 'x' FROM [mylan_UnitOfMeasure] WHERE Description = @Description)           
     BEGIN    
     
    SELECT TOP 1 @MaxId = Id From mylan_UnitOfMeasure Order By Id desc   
       INSERT INTO [mylan_UnitOfMeasure] (Code, Description, Approved)          
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description,  0)          
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
                    Approved = 0          
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
                      Approved = 0          
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
                      Approved = 0          
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
              Approved = 0          
         FROM [Area] X          
         WHERE Id= @Id          
         SET @ReturnValue = 101          
       END          
     END          
     IF(@Type = 'room')          
     BEGIN          
       IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId AND Id <> @Id AND (@Column1 = '' OR DeviceIPAddress = @Column1))          
       BEGIN          
         UPDATE X SET   Code = @Code,          
             [Description] = @Description,          
             AreaId = @ParentId,          
            Approved = 0,
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
            Approved = 0          
         FROM [mylan_UnitOfMeasure] X          
         WHERE Id= @Id          
         SET @ReturnValue = 101          
       END                 
     END         
   END          
   RETURN @ReturnValue          
END   

GO


GO

/****** Object:  StoredProcedure [dbo].[sprocGetRoomByIPAddress]    Script Date: 3/23/2022 12:06:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[sprocGetRoomByIPAddress]
@IPAddress VARCHAR(20)
AS
BEGIN
  
  SELECT R.Id,   
   R.Code,  
   R.Description,  
   R.AreaId as ParentId,  
   R.Code AS ParentCode,
   A.Description as ParentDescription , 
   ISNULL(R.Approved,0) AS Approved ,
   ISNULL(DeviceIPAddress, '') AS DeviceIPAddress
   From Room R  
   INNER JOIN Area A on A.Id = R.AreaId  
   WHERE  R.Approved = 1 AND DeviceIPAddress = @IPAddress

END

GO