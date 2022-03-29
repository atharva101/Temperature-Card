
  
CREATE Procedure [dbo].[sprocAddEditBatch]  
@Id           INT  
,@RoomIds     VARCHAR(MAX)
,@ProductId   INT  
,@BatchNumber VARCHAR(200)  
,@BatchSize   INT  
,@Status      VARCHAR(200)  
,@UserId      INT
,@ReturnValue   INT OUTPUT 
AS  
BEGIN  
  SET @ReturnValue = -101
  DECLARE @INSERTEDBatchId INT = -1;
  IF(ISNULL(@Id,0) < 1)  
  BEGIN
    IF NOT EXISTS(SELECT 'x' FROM [BATCH] WHERE BatchNumber = @BatchNumber)
    BEGIN
      INSERT INTO dbo.BATCH (  
           [ProductId]  
           ,[BatchNumber]  
           ,[BatchSize]  
           ,[Status]  
           ,[AddedBy]  
           ,[AddedOn]  
        )  
      SELECT   
        @ProductId   
        ,@BatchNumber  
        ,@BatchSize   
        ,@Status   
        ,@UserId   
        ,GETDATE()  
       
      SET @INSERTEDBatchId = (SELECT SCOPE_IDENTITY())  
      SET @ReturnValue = 101
    END
  END  
  ELSE  
  BEGIN 
     IF NOT EXISTS(SELECT 'x' FROM [BATCH] WHERE BatchNumber = @BatchNumber AND Id <> @Id)
     BEGIN 
       UPDATE dbo.Batch  
       SET    
            [ProductId] = @ProductId  
            ,[BatchNumber] = @BatchNumber  
            ,[BatchSize] = @BatchSize  
            ,[Status] = @Status  
            ,[UpdatedBy] = @UserId  
            ,[UpdatedOn] = GETDATE()
            WHERE Id = @Id
       SET @INSERTEDBatchId = @Id
       SET @ReturnValue = 101
    END
  END 
      
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
            
CREATE Procedure [dbo].[sprocAddEditMaster]            
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
         WHERE Id= @Id  AND NOT EXISTS (SELECT 1 FROM Room WHERE DeviceIPAddress = @Column1)          
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditRolePermission]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE  procedure [dbo].[sprocAddEditRolePermission]  
@RoleId INT,  
@PermissionIds varchar(1000),  
@RoleName VARCHAR(100),  
@RoleDescription VARCHAR(500),  
@ReturnValue   INT OUTPUT   
AS  
BEGIN
  SET @ReturnValue = -101
  IF(@PermissionIds IS NULL) SET @PermissionIds = ''

  DECLARE @XML AS XML
  DECLARE @Delimiter AS CHAR(1) =',' 
  SET @XML = CAST(('<X>'+REPLACE(@PermissionIds,@Delimiter ,'</X><X>')+'</X>') AS XML)
  DECLARE @tempPermissionId TABLE (VALUE INT)
  INSERT INTO @tempPermissionId
  SELECT N.value('.', 'INT') AS ID FROM @XML.nodes('X') AS T(N)

  DECLARE @Id INT  
  IF @RoleId = 0  
  BEGIN  
    IF NOT EXISTS(SELECT 'x' FROM [Role] WHERE Name = @RoleName)  
    BEGIN  
      INSERT INTO [Role] (Name,Description,SysRole, Approved)  
      VALUES(@RoleName, @RoleDescription,0,0)  
      SET @Id = SCOPE_IDENTITY()  
        
      INSERT INTO RolePermission(RoleId,PermissionId)  
      SELECT DISTINCT @id, VALUE FROM @tempPermissionId
      SET @ReturnValue = 101  
    END  
      
  END  
  ELSE  
  BEGIN  
    DELETE FROM RolePermission WHERE RoleId = @RoleId  
    
    UPDATE Role   
      SET Name=  @RoleName,  
       Description = @RoleDescription,  
          Approved = 0  
    WHERE Id =@RoleId  
    
    INSERT INTO RolePermission(RoleId,PermissionId)  
    SELECT DISTINCT @RoleId, VALUE FROM @tempPermissionId  
    SET @ReturnValue = 101  
  END  
  RETURN @ReturnValue  
END  
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditUser]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE Procedure [dbo].[sprocAddEditUser]  
@UserId      INT,  
@FirstName   VARCHAR(50),  
@LastName    VARCHAR(50),  
@Email       VARCHAR(50),  
@UserName    VARCHAR(50),  
@IsDisabled  BIT,  
@IsDeleted   BIT,  
@RoleId      INT,  
@Password    VARCHAR(50),
@UserRooms   VARCHAR(MAX),
@ReturnValue INT OUTPUT  
AS  
BEGIN
  IF(@UserRooms is NULL)
  BEGIN
    SET @UserRooms = ''
  END
  DECLARE @XML AS XML
  DECLARE @Delimiter AS CHAR(1) =','
  SET @XML = CAST(('<X>'+REPLACE(@UserRooms,@Delimiter ,'</X><X>')+'</X>') AS XML)
  
  DECLARE @temp TABLE (ID INT)
  INSERT INTO @temp
  SELECT N.value('.', 'INT') AS ID FROM @XML.nodes('X') AS T(N)
  
  IF(ISNULL(@UserId,0) < 1)  
  BEGIN  
    --CHECK EMAIL  
    DECLARE @EmailCount INT  
    SELECT @EmailCount = COUNT(*) FROM [User] WHERE Email = @Email AND @FirstName <> 'Device' AND @RoleId <> -1  
    IF @EmailCount > 0   
    BEGIN  
    SET @ReturnValue = -9  
    RETURN @ReturnValue  
    END  
       
      
    --Check USERNAME  
    DECLARE @UserNameCount INT  
    SELECT @UserNameCount = COUNT(*) FROM [User] WHERE UserName = @UserName  
    IF @UserNameCount > 0   
    BEGIN  
    SET @ReturnValue = -10  
    RETURN @ReturnValue  
    END  
     
  
    DECLARE @OutputTable TABLE (UserId INT)      
    INSERT INTO [User] (FirstName,LastName,Email,UserName,RoleId,IsDisabled,IsDeleted)  
    OUTPUT inserted.Id INTO @OutputTable(UserId)  
    VALUES (@FirstName,@LastName,@Email,@UserName,@RoleId,0,0)  
  
    DECLARE @InsertedUserID INT;  
    SELECT TOP 1 @InsertedUserID = UserId FROM @OutputTable  
    INSERT INTO LoginInfo (UserId,Password,IncorrectAttempt,LastLogInTime,Blocked,ForceChangePassword)  
    SELECT @InsertedUserID, @Password, 0, NULL,0, 1  
    
	INSERT INTO UserRoom(UserId, RoomId)
	SELECT @InsertedUserID, ID FROM @temp

    SET @ReturnValue = -103  
    RETURN @ReturnValue   
  END  
  ELSE  
  BEGIN  
    DECLARE @IsEmailChanged INT  
    SELECT @IsEmailChanged = COUNT(*) FROM [User] WHERE Id = @UserId AND Email <> @Email  
    UPDATE U SET FirstName = @FirstName,  
                      LastName = @LastName,  
                      Email = CASE WHEN @IsEmailChanged > 0 THEN @Email ELSE U.Email END,  
                      UserName = @UserName,  
                      RoleId = @RoleId,  
                      IsDisabled = @IsDisabled,  
                      IsDeleted = @IsDeleted  
    FROM [User] U  
    WHERE Id= @UserId  
  
    UPDATE LoginInfo  SET Password = @Password WHERE UserId = @UserId AND @IsEmailChanged > 0  
    
	DELETE FROM UserRoom WHERE UserId = @UserId

	INSERT INTO UserRoom(UserId, RoomId)
	SELECT @UserId, ID FROM @temp

    IF(@IsEmailChanged > 0)  
    BEGIN  
      SET @ReturnValue = -103  
      RETURN @ReturnValue  
    END  
    SET @ReturnValue = -101  
    RETURN @ReturnValue  
  END  
END  
GO
/****** Object:  StoredProcedure [dbo].[sprocApproveMaster]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE Procedure [dbo].[sprocApproveMaster]    
@Type   VARCHAR(50),    
@Id  INT = 0    
    
AS    
BEGIN  
  IF(@Type = 'plant')    
  BEGIN    
    Update Plant SET Approved = 1  
    WHERE Id = @Id     
  END    
  ELSE IF(@Type = 'block')    
  BEGIN    
    Update [Block] SET Approved = 1  
    WHERE Id = @Id  
  END    
  ELSE IF(@Type = 'area')    
  BEGIN    
    Update Area SET Approved = 1  
    WHERE Id = @Id     
  END    
  ELSE IF(@Type = 'room')    
  BEGIN    
    Update Room SET Approved = 1  
    WHERE Id = @Id     
  END   
  ELSE IF(@Type = 'product')    
  BEGIN    
    Update mylan_ProductMaster SET Approved = 1  
    WHERE Id = @Id    
  END  
  ELSE IF(@Type = 'role')    
  BEGIN    
    Update Role SET Approved = 1  
    WHERE Id = @Id    
  END  
  ELSE IF(@Type = 'batch')    
  BEGIN    
    Update Batch SET Approved = 1  
    WHERE Id = @Id    
  END  
  ELSE IF(@Type = 'uom')    
  BEGIN    
    Update mylan_UnitOfMeasure SET Approved = 1  
    WHERE Id = @Id    
  END  
END    
    
    
GO
/****** Object:  StoredProcedure [dbo].[sprocAssignBatchToRoom]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sprocAssignBatchToRoom]
@BatchId INT,
@RoomId INT,
@UserId  INT
AS   
BEGIN
  DECLARE @WFStatus INT
  SELECT TOP 1 @WFStatus = Id From dbo.StatusWorkFlow Where [Order] = 1
  
  DECLARE @BatchSize INT
  DECLARE @UOM INT
  SELECT @BatchSize = BatchSize, @UOM = P.UOM  FROM Batch B
  INNER JOIN mylan_ProductMaster P ON P.Id = B.ProductId WHERE B.Id = @BatchId

  DECLARE @LastBatch INT
  SELECT TOP 1 @LastBatch = BatchId FROM RoomLog WHERE RoomId = @RoomId ORDER BY ID DESC
  IF(@LastBatch IS NULL OR @LastBatch <> @BatchId)
  BEGIN
    INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp], BatchId,[BatchSize],UOM, UserId)         
    SELECT  @RoomId, @WFStatus, GETDATE(), @BatchId,@BatchSize,@UOM, @UserId       
  END

END
GO
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[sprocChangeRoomStatus]
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

IF (@BatchId = -1 )
BEGIN
DECLARE @NoActivityStatus INT
SELECT TOP 1 @NoActivityStatus = Id FROM StatusWorkFlow WHERE StatusWorkFlow.[Order] = 1

SELECT TOP 1 @BatchId = BatchId , @BatchSize = [BatchSize] , @UOMId = UOM
FROM RoomLog
WHERE RoomId = @RoomId AND StatusId = @NoActivityStatus
ORDER BY Id desc
END

select TOP 1 @RoomCurrentStatusId = StatusId  FROM RoomLog WHERE RoomId = @RoomId ORDER BY Id DESC;
-- Create a record in RoomLog
INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp], BatchId, [BatchSize], UOM, UserId)
SELECT  @RoomId, @StatusId, GETDATE(), @BatchId, @BatchSize, @UOMId, @UserId
WHERE @StatusId <> @RoomCurrentStatusId

END
GO
/****** Object:  StoredProcedure [dbo].[sprocDeleteMaster]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sprocDeleteMaster]        
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
/****** Object:  StoredProcedure [dbo].[sprocEditBatchSize]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[sprocEditBatchSize]
@RoomId     INT,
@BatchId	INT,
@BatchSize	INT,
@UOM		VARCHAR(200)

AS
BEGIN
  DECLARE @UOMId INT
  SELECT @UOMId = Id FROM mylan_UnitOfMeasure WHERE [Description]= @UOM

  UPDATE RoomLog SET [BatchSize] = @BatchSize ,
                     [UOM] = @UOMId
  WHERE RoomId = @RoomId AND BatchId = @BatchId
END
GO
/****** Object:  StoredProcedure [dbo].[sprocGetAvailableBatches]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[sprocGetAvailableBatches]
@RoomId INT 
AS
BEGIN
  SELECT [Id]
		  ,[ProductId]
		  ,[BatchNumber]
		  ,[BatchSize]
		  ,[Status]
		  ,[AddedBy]
		  ,[AddedOn]
		  ,[UpdatedBy]
		  ,[UpdatedOn]
		  ,ISNULL([Approved],0) AS [Approved]
	  FROM [dbo].[Batch] CT 
      
END

GO
/****** Object:  StoredProcedure [dbo].[sprocGetBatch]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sprocGetBatch]      
@ReadyToAssign BIT = 0 ,      
@RoomId INT = 0      
AS      
BEGIN      

SELECT CT.[Id]      
    ,[ProductId]      
    ,[BatchNumber]      
    ,[BatchSize]   
 , uom.Description AS UOM  
    ,[Status]      
    ,[AddedBy]      
    ,[AddedOn]      
    ,[UpdatedBy]      
    ,[UpdatedOn]      
    ,ISNULL(CT.[Approved],0) AS [Approved]      
   FROM [dbo].[Batch]CT  
   INNER JOIN mylan_ProductMaster P ON P.Id = CT.ProductId  
   INNER JOIN mylan_UnitOfMeasure uom ON uom.Id = P.UOM  
      
      
END 
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 29-03-2022 10:06:01 ******/
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








GO
/****** Object:  StoredProcedure [dbo].[sprocGetMasterHierarchy]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetMasterHierarchy] 
  
AS  
BEGIN
  SELECT Id, PlantName As Code, Location As Description, 0 AS ParentId, 'plant' AS Type
  FROM Plant
  UNION 
  SELECT Id, Code, Description, PlantId AS ParentId, 'block' AS Type
  FROM Block
  UNION 
  SELECT Id, Code, Description, BlockId AS ParentId, 'area' AS Type
  FROM Area
  UNION 
  SELECT Id, Code, Description, AreaId AS ParentId, 'room' AS Type
  FROM Room

END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMenus]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
    
CREATE Procedure [dbo].[sprocGetMenus]    
@UserId   INT    
AS    
BEGIN
  CREATE TABLE #Menu
  (
    Id         INT, 
    Title      VARCHAR(100),  
    Type       VARCHAR(50), 
    URL        VARCHAR(500), 
    Icon       VARCHAR(100),
    Target     BIT,
    Breadcrumbs BIT,
    Classes     VARCHAR(500),
    ParentId    INT
  )
  INSERT INTO #Menu
  SELECT M.Id  
        ,M.Title  
        ,M.Type  
        ,M.URL  
        ,M.Icon  
        ,M.Target  
        ,M.Breadcrumbs  
        ,M.Classes  
        ,ISNULL(M.ParentId,0) AS ParentId  
  FROM Menu M WHERE  M.Type <> 'item'  
  UNION  
  SELECT M.Id  
        ,M.Title  
        ,M.Type  
        ,M.URL  
        ,M.Icon  
        ,M.Target  
        ,M.Breadcrumbs  
        ,M.Classes  
        ,ISNULL(M.ParentId,0) AS ParentId  
  FROM Menu M  
  INNER JOIN MenuPermission MP ON M.Id = MP.MenuId  
  INNER JOIN RolePermission RP ON RP.PermissionId = MP.PermissionId  
  INNER JOIN Role R ON RP.RoleId = R.Id  
  INNER JOIN [User] U ON U.RoleId = R.Id  
  WHERE U.Id = @UserId AND M.Type = 'item'  
  
  DELETE M FROM #Menu M
  WHERE [Type] = 'collapse'
  AND NOT EXISTS (SELECT 1 FROM #Menu WHERE ParentId = M.Id)

  SELECT * FROM #Menu
END    
    
    
GO
/****** Object:  StoredProcedure [dbo].[sprocGetPermissions]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetPermissions]  
AS  
BEGIN
  Select Id, PermissionName,GroupName 
  FROM Permission
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetPlantMaster]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sprocGetPlantMaster]  
@Type   VARCHAR(50),  
@ParentId  INT = 0,  
@ApproveOnly BIT = 0
AS  
BEGIN  
  Select Id, PlantName As Code, Location  As Description, 0 AS ParentId, '' AS ParentCode, '' AS ParentDescription, ISNULL(Approved,0) AS Approved from Plant
  UNION
  Select Id, Code, Description, PlantId AS ParentId, '' AS ParentCode, '' AS ParentDescription, ISNULL(Approved,0) AS Approved from Block
  
END  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoles]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetRoles] 
@ApproveOnly BIT = 0
AS  
BEGIN
  SELECT Id
        ,[Name]
        ,[Description]
        ,ISNULL(SysRole,0) AS SysRole
        ,ISNULL(Approved,0) AS Approved
  FROM [Role]
  WHERE Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE Approved END

  SELECT Id, PermissionId,RoleId
  FROM RolePermission
  

END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomByIPAddress]    Script Date: 29-03-2022 10:06:01 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomMaster]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetRoomMaster] 
  
AS  
BEGIN
  Select R.Id AS RoomId, R.Code As RoomCode, R.Description As RoomDescription,
       A.Id AS AreaId, A.Code As AreaCode, A.Description As AreaDescription,
       B.Id AS BlockId, B.Code As BlockCode, B.Description As BlockDescription,
       P.Id AS PlantId, P.PlantName, P.Location As PlantLocation
  FROM Room R
  INNER JOIN Area A ON R.AreaId = A.Id 
  INNER JOIN Block B ON A.BlockId = B.Id
  INNER JOIN Plant P ON B.PlantId = P.Id 
  WHERE R.Approved = 1
END  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
     
   
     
CREATE Procedure [dbo].[sprocGetRoomStatus]                    
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
INNER JOIN (      
   SELECT max(Id) as Id FROM RoomLog RLSub
   Group By RoomId      
   ) RLTop ON RLTop.Id = RL.Id      
INNER JOIN dbo.Room R ON RL.RoomId = R.Id      
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
INNER JOIN (      
   SELECT max(Id) as Id FROM RoomLog RLSub
   Group By RoomId      
   ) RLTop ON RLTop.Id = RL.Id
INNER JOIN dbo.Batch B On B.Id = RL.BatchId      
INNER JOIN dbo.mylan_ProductMaster P ON P.Id = B.ProductId  
LEFT JOIN mylan_UnitOfMeasure uom ON uom.Id = RL.UOM  
INNER JOIN dbo.StatusWorkFlow W ON W.Id = temp.RoomStatusId    
                                    AND (W.ProductProcessing = 1 OR W.[Order] =1)    
  
-----------------------TODO
     
   
INSERT INTO #RoomLog (    
   RoomId      
  ,RoomStatusId    
  ,RoomStatus        
  ,RoomStatusOrder   
  )    
Select R.RoomId, SWF.Id, SWF.Status, SWF.[Order] FROM #Rooms R    
CROSS JOIN StatusWorkFlow SWF

DECLARE @AssignedBatchId INT  
SELECT TOP 1 @AssignedBatchId = rl.BatchId FROM RoomLog rl
INNER JOIN #Rooms r ON r.RoomId = rl.RoomId order by Id desc 
   
UPDATE tempRL    
SET tempRL.[TimeStamp] = RL.TimeStamp,    
    tempRL.UserName = U.FirstName + ' '+ U.LastName    
FROM #RoomLog tempRL    
INNER JOIN dbo.RoomLog RL ON RL.RoomId = tempRL.RoomId AND RL.StatusId = tempRL.RoomStatusId 
INNER JOIN [User] U ON U.Id = RL.UserId
INNER JOIN (    
  SELECT MAX(Id) as Id    
  FROM dbo.RoomLog    
  Group by roomId, StatusId    
) RLTop ON RL.Id = RLTop.Id 
WHERE RL.BatchId = @AssignedBatchId     
   
     
SELECT * FROM #Rooms R ORDER BY RoomId asc, [TimeStamp] desc    
SELECT * FROM #RoomLog ORDER BY RoomId, RoomStatusOrder      
     
DROP Table #Rooms                    
DROP Table #RoomLog                
               
END      
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatusWorkFlow]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sprocGetRoomStatusWorkFlow]                      
AS              
BEGIN              
              
SELECT Id, [Status], [Order], IsFinal FROM dbo.StatusWorkFlow ORDER BY [Order]     
          
END 



GO
/****** Object:  StoredProcedure [dbo].[sprocGetUser]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sprocGetUser]              
           
AS              
BEGIN              
  SELECT Id AS Id,
         FirstName AS [FirstName],
		 LastName  AS [LastName],
		 Email AS [Email],
		 UserName AS [UserName],
		 RoleId AS [RoleId],
		 IsDisabled AS [IsDisabled],
		 IsDeleted AS [IsDeleted]
  FROM [User]          
END
GO
/****** Object:  StoredProcedure [dbo].[sprocGetUserPermissions]    Script Date: 29-03-2022 10:06:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetUserPermissions]  
@UserId   INT  
AS  
BEGIN
  SELECT P.Id, P.PermissionName
  FROM [User] U
  INNER JOIN [Role] R ON U.RoleId = R.Id
  INNER JOIN RolePermission RP ON RP.RoleId = R.Id
  INNER JOIN Permission P ON RP.PermissionId = P.Id
  WHERE U.Id = @UserId

END  
  
GO
