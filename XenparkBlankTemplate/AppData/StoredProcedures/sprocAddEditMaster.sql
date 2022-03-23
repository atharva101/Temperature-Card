USE [weavingplantdb]
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


