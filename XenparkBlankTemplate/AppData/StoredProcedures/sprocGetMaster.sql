USE [weavingplantdb]
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


