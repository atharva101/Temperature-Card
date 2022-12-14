USE [XenparkBlankDB]
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditBatch]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
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
  
  IF  @ReturnValue = 101 AND LEN(@RoomIds) > 0
    BEGIN
      SELECT DISTINCT VALUE INTO #TempRoomIds FROM STRING_SPLIT(@RoomIds,',')
      DECLARE @count INT;

      INSERT INTO dbo.BatchLogger(BatchId, RoomId, [TimeStamp], IsCompleted)  
      SELECT @INSERTEDBatchId, R.VALUE, GETDATE() , 0
      FROM #TempRoomIds R
      WHERE NOT EXISTS (SELECT 1 FROM BatchLogger WHERE BatchId = @INSERTEDBatchId AND RoomId = R.VALUE)
      
      -- Create a record in RoomLog If No Record for Room  
      DECLARE @WFStatus INT   
      SELECT TOP 1 @WFStatus = Id From dbo.StatusWorkFlow Where [Order] = 1   
      INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp])  
      SELECT  R.VALUE, @WFStatus, GETDATE()
      FROM #TempRoomIds R
      WHERE NOT EXISTS (SELECT 1 FROM RoomLog WHERE RoomId = R.VALUE)

    END
      
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sprocAddEditMaster]
@Id          INT,
@Code      VARCHAR(100),
@Description VARCHAR(50),
@ParentId    int,
@Type   VARCHAR(50),
@ReturnValue   INT OUTPUT 
AS
BEGIN
  SET @ReturnValue = -101
  DECLARE @PlantId INT;
  IF(ISNULL(@Id,0) < 1)
  BEGIN
   IF(@Type = 'product')
   BEGIN
     IF NOT EXISTS(SELECT 'x' FROM [ProductMaster] WHERE code = @Code)
     BEGIN
       INSERT INTO [ProductMaster] (Code, Description,Approved)
       VALUES (@Code, @Description, 0)
       SET @ReturnValue = 101
     END
   END
   IF(@Type = 'plant')
   BEGIN
          
     IF NOT EXISTS(SELECT 'x' FROM [Plant] WHERE PlantName = @Code AND Location = @Description)
     BEGIN
       INSERT INTO [Plant] (PlantName, Location, Approved)
       VALUES (@Code, @Description, 0)
       SET @ReturnValue = 101
     END
   END
   IF(@Type = 'block')
   BEGIN
     IF NOT EXISTS(SELECT 'x' FROM [Block] WHERE Code = @Code AND PlantId = @ParentId)
     BEGIN
       INSERT INTO [Block] (Code, Description, PlantId, Approved)
       VALUES (@Code, @Description, @ParentId, 0)
       SET @ReturnValue = 101
     END
   END
   IF(@Type = 'area')
   BEGIN     
     SELECt @PlantId = PlantId FROM Block WHERE Id = @ParentId;
     IF NOT EXISTS(SELECT 'x' FROM [Area] A
           INNER JOIN [Block] B ON A.BlockId = B.Id
           INNER JOIN Plant P ON P.Id = B.PlantId WHERE A.Code = @Code AND P.Id = @PlantId) -- Unique in Plant
     BEGIN
       INSERT INTO [Area] (Code, Description, BlockId, Approved)
       VALUES (@Code, @Description, @ParentId, 0)
       SET @ReturnValue = 101
     END
   END
   IF(@Type = 'room')
   BEGIN
     IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId) 
     BEGIN
       INSERT INTO [Room] (Code, Description, AreaId, Status, Approved)
       VALUES (@Code, @Description, @ParentId,null, 0)
       SET @ReturnValue = 101
     END
   END
   END
   ELSE
   BEGIN
    IF(@Type = 'product')
     BEGIN
       IF NOT EXISTS(SELECT 'x' FROM [ProductMaster] WHERE code = @Code)
       BEGIN
         UPDATE X SET Code = @Code,
                    [Description] = @Description,
                    Approved = 0
         FROM [ProductMaster] X
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
       IF NOT EXISTS(SELECT 'x' FROM [Block] WHERE Code = @Code AND PlantId = @ParentId AND Id <> @Id)
       BEGIN
         UPDATE X SET Code = @Code,
                      [Description] = @Description,
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
           INNER JOIN Plant P ON P.Id = B.PlantId WHERE A.Code = @Code AND P.Id = @PlantId AND A.Id <> @Id) -- Unique in Plant
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
       IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code AND AreaId = @ParentId AND Id <> @Id)
       BEGIN
         UPDATE X SET   Code = @Code,
             [Description] = @Description,
             AreaId = @ParentId,
            Approved = 0
         FROM [Room] X
         WHERE Id= @Id
         SET @ReturnValue = 101
       END       
     END
   END
   RETURN @ReturnValue
END
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditRolePermission]    Script Date: 14-07-2021 18:44:53 ******/
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
  DECLARE @Id INT
  IF @RoleId = 0
  BEGIN
    IF NOT EXISTS(SELECT 'x' FROM [Role] WHERE Name = @RoleName)
    BEGIN
      INSERT INTO [Role] (Name,Description,SysRole, Approved)
      VALUES(@RoleName, @RoleDescription,0,0)
      SET @Id = SCOPE_IDENTITY()
      
      INSERT INTO RolePermission(RoleId,PermissionId)
      SELECT DISTINCT @id, VALUE FROM STRING_SPLIT(@PermissionIds,',')
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
    SELECT DISTINCT @RoleId, VALUE FROM STRING_SPLIT(@PermissionIds,',')
    SET @ReturnValue = 101
  END
  RETURN @ReturnValue
END
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditUser]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[sprocAddEditUser]
@UserId      INT,
@FirstName   VARCHAR(50),
@LastName    VARCHAR(50),
@Email       VARCHAR(50),
@UserName    VARCHAR(50),
@IsDisabled  BIT,
@IsDeleted   BIT,
@RoleId      INT,
@Password    VARCHAR(50),
@ReturnValue INT OUTPUT
AS
BEGIN
  

  IF(ISNULL(@UserId,0) < 1)
  BEGIN
    --CHECK EMAIL
    DECLARE @EmailCount INT
    SELECT @EmailCount = COUNT(*) FROM [User] WHERE Email = @Email
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
/****** Object:  StoredProcedure [dbo].[sprocApproveMaster]    Script Date: 14-07-2021 18:44:53 ******/
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
    Update ProductMaster SET Approved = 1
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
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocAssignBatchToRoom]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  
CREATE Procedure [dbo].[sprocAssignBatchToRoom]  
@BatchId INT  
,@RoomId INT  
AS  
BEGIN  
      DECLARE @count INT;

      INSERT INTO dbo.BatchLogger(BatchId, RoomId, [TimeStamp], IsCompleted)  
      SELECT @BatchId, @RoomId, GETDATE() , 0
      WHERE NOT EXISTS (SELECT 1 FROM BatchLogger WHERE BatchId = @BatchId AND RoomId = @RoomId)
      
      -- Create a record in RoomLog If No Record for Room  
      DECLARE @WFStatus INT   
      SELECT TOP 1 @WFStatus = Id From dbo.StatusWorkFlow Where [Order] = 1   
      INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp])  
      SELECT  @RoomId, @WFStatus, GETDATE()
      WHERE NOT EXISTS (SELECT 1 FROM RoomLog WHERE RoomId = @RoomId)
END  

GO
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[sprocChangeRoomStatus]
@RoomId INT,
@BatchId INT,
@StatusId INT
AS
BEGIN
-- -- Create a record in BatchLogger
--INSERT INTO dbo.BatchLogger(BatchId, RoomId, [TimeStamp])
--SELECT @BatchId, @RoomId, GETDATE()

-- Create a record in RoomLog
INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp])
SELECT  @RoomId, @StatusId, GETDATE()
WHERE NOT EXISTS (SELECT 1 FROM BatchLogger WHERE BatchId = @BatchId  AND RoomId =@RoomId AND ISCompleted = 1)


DECLARE @StatusOrder INT;
SELECT @StatusOrder = [Order] FROM StatusWorkFlow WHERE Id = @StatusId

UPDATE BatchLogger SET ISCompleted = 1
WHERE BatchId = @BatchId  AND RoomId =@RoomId AND @StatusOrder = 1

END


GO
/****** Object:  StoredProcedure [dbo].[sprocGetAvailableBatches]    Script Date: 14-07-2021 18:44:53 ******/
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
      WHERE NOT EXISTS(SELECT 1 FROM BatchLogger BL WHERE BL.BatchId = CT.Id AND BL.RoomId = @RoomId) 
END

GO
/****** Object:  StoredProcedure [dbo].[sprocGetBatch]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[sprocGetBatch]
@ReadyToAssign BIT = 0 
AS
BEGIN
IF @ReadyToAssign = 0 
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
	  FROM [dbo].[Batch]CT 

	SELECT Id,
		   BatchId,
		   RoomId,
		   TimeStamp
	FROM BatchLogger
END
ELSE 
BEGIN
DECLARE @RoomId INT = -1
CREATE TABLE #Rooms                
(                
  RoomId   int,  
  RoomCode       varchar(200),  
  RoomDesc   varchar(200),  
  ProductId      int,   
  ProductCode  varchar(200),  
  ProductDesc  varchar(200),  
  BatchId   int,  
  BatchNumber    varchar(200),  
  BatchSize      int,  
  RoomStatusId   int,  
  RoomCurrentStatus     varchar(200),  
  RoomStatusOrder int,  
  [TimeStamp]  DATETIME,
  Plant varchar(200),
  Block varchar(200) ,
  Area varchar(200),
) 
INSERT INTO #Rooms (RoomId  
  ,RoomCode  
  ,RoomDesc
  ,Plant
  ,Block
  ,Area)  
SELECT R.Id,R.Code,R.Description, P.PlantName, 
B.Code + (CASE WHEN ISNULL(B.Description, '') <> '' THEN '-' ELSE '' END) + B.Description,
A.Code + (CASE WHEN ISNULL(A.Description, '') <> '' THEN '-' ELSE '' END) + A.Description
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
   --WHERE  
   --Convert(DATE, RLSub.TimeStamp) = Convert(Date, @Date)   
   Group By RoomId  
   ) RLTop ON RLTop.Id = RL.Id  
INNER JOIN dbo.Room R ON RL.RoomId = R.Id  
INNER JOIN dbo.StatusWorkFlow SWF ON SWF.Id = RL.StatusId   
--WHERE Convert(DATE, RL.TimeStamp) = Convert(Date, @Date)  
   
  
UPDATE temp  
SET ProductId  =  B.ProductId     
  ,ProductCode =  P.Code    
  ,ProductDesc = P.Description   
  ,BatchId    = BL.BatchId  
  ,BatchNumber = B.BatchNumber    
  ,BatchSize  = B.BatchSize  
FROM #Rooms temp  
INNER Join (  
   SELECT min(Id) as Id, RoomId FROM BatchLogger BLSub  
   WHERE ISNULL(IsCompleted, 0)  = 0
   --WHERE Convert(DATE, BLSub.TimeStamp) = Convert(Date, @Date)   
   Group By RoomId  
   ) BLTop ON BLTop.RoomId  = temp.RoomId    
INNER JOIN dbo.BatchLogger BL ON BL.Id = BLTop.Id   
INNER JOIN dbo.Batch B On B.Id = BL.BatchId  
INNER JOIN dbo.ProductMaster P ON P.Id = B.ProductId 
INNER JOIN dbo.StatusWorkFlow W ON W.Id = temp.RoomStatusId 
                                    --AND W.ProductProcessing = 1
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
	  WHERE ISNULL([Approved], 0) = 1 AND 
	  NOT EXISTS(SELECT 1 FROM BatchLogger BL WHERE BL.BatchId = CT.Id AND BL.IsCompleted = 1) AND
	  NOT EXISTS (SELECT 1 FROM #Rooms R
				  INNER JOIN StatusWorkFlow SWF ON SWF.Id = R.RoomStatusId 
				  Where R.BatchId = CT.Id and ((ISNULL(SWF.ProductProcessing, 0) = 1 )  OR ISNULL(SWF.[Order], 0) = 1)  )

DROP TABLE #Rooms

END 


END
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 14-07-2021 18:44:53 ******/
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
   R.Code AS ParentCode,
   A.Description as ParentDescription , 
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
   0 as ParentId,  
   '' AS ParentCode,
   '' as ParentDescription , 
   ISNULL(P.Approved,0) AS Approved
   From ProductMaster P
   WHERE P.Approved = CASE WHEN @ApproveOnly = 1 THEN 1 ELSE P.Approved END
 END 
END  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMenus]    Script Date: 14-07-2021 18:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetMenus]  
@UserId   INT  
AS  
BEGIN
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

END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetPermissions]    Script Date: 14-07-2021 18:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetPlantMaster]    Script Date: 14-07-2021 18:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoles]    Script Date: 14-07-2021 18:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomMaster]    Script Date: 14-07-2021 18:44:53 ******/
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
  INNER JOIN Area A ON R.AreaId = A.Id AND A.Approved = 1
  INNER JOIN Block B ON A.BlockId = B.Id AND B.Approved = 1
  INNER JOIN Plant P ON B.PlantId = P.Id AND B.Approved = 1
  WHERE R.Approved = 1
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 14-07-2021 18:44:53 ******/
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
  ProductDesc  varchar(200),  
  BatchId   int,  
  BatchNumber    varchar(200),  
  BatchSize      int,  
  RoomStatusId   int,  
  RoomCurrentStatus     varchar(200),  
  RoomStatusOrder int,  
  [TimeStamp]  DATETIME,
  Plant varchar(200),
  Block varchar(200) ,
  Area varchar(200),
)          
  
CREATE TABLE #RoomLog              
(              
  RoomId		 int,
  RoomStatusId   int,
  RoomStatus     varchar(200),
  RoomStatusOrder int  ,
  [TimeStamp]	 DATETIME,
  ToTimeStamp    DATETIME,
  IsFinal		 BIT,
  IsPrev 		 BIT,
  IsCurrent		 BIT,
  IsNext		 BIT
) 
  
INSERT INTO #Rooms (RoomId  
  ,RoomCode  
  ,RoomDesc
  ,Plant
  ,Block
  ,Area)  
SELECT R.Id,R.Code,R.Description, P.PlantName, 
B.Code + (CASE WHEN ISNULL(B.Description, '') <> '' THEN '-' ELSE '' END) + B.Description,
A.Code + (CASE WHEN ISNULL(A.Description, '') <> '' THEN '-' ELSE '' END) + A.Description
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
   --WHERE  
   --Convert(DATE, RLSub.TimeStamp) = Convert(Date, @Date)   
   Group By RoomId  
   ) RLTop ON RLTop.Id = RL.Id  
INNER JOIN dbo.Room R ON RL.RoomId = R.Id  
INNER JOIN dbo.StatusWorkFlow SWF ON SWF.Id = RL.StatusId   
--WHERE Convert(DATE, RL.TimeStamp) = Convert(Date, @Date)  
   
  
UPDATE temp  
SET ProductId  =  B.ProductId     
  ,ProductCode =  P.Code    
  ,ProductDesc = P.Description   
  ,BatchId    = BL.BatchId  
  ,BatchNumber = B.BatchNumber    
  ,BatchSize  = B.BatchSize  
FROM #Rooms temp  
INNER Join (  
   SELECT min(Id) as Id, RoomId FROM BatchLogger BLSub  
   WHERE ISNULL(IsCompleted, 0)  = 0
   --WHERE Convert(DATE, BLSub.TimeStamp) = Convert(Date, @Date)   
   Group By RoomId  
   ) BLTop ON BLTop.RoomId  = temp.RoomId    
INNER JOIN dbo.BatchLogger BL ON BL.Id = BLTop.Id   
INNER JOIN dbo.Batch B On B.Id = BL.BatchId  
INNER JOIN dbo.ProductMaster P ON P.Id = B.ProductId 
INNER JOIN dbo.StatusWorkFlow W ON W.Id = temp.RoomStatusId 
                                    AND W.ProductProcessing = 1
--WHERE Convert(DATE, temp.TimeStamp) = Convert(Date, @Date)   
  

INSERT INTO #RoomLog ( 
	RoomId		 
  ,RoomStatusId 
  ,RoomStatus     
  ,RoomStatusOrder
  ,IsFinal
  , IsPrev
  , IsNext
  , IsCurrent
  )
Select R.RoomId, SWF.Id, SWF.Status, SWF.[Order], SWF.IsFinal, 0, 0, 0 FROM #Rooms R
CROSS JOIN StatusWorkFlow SWF 

UPDATE tempRL
SET tempRL.[TimeStamp] = RL.TimeStamp
  --,tempRL.ToTimeStamp = RL.ToTimeStamp
FROM #RoomLog tempRL
INNER JOIN dbo.RoomLog RL ON RL.RoomId = tempRL.RoomId AND RL.StatusId = tempRL.RoomStatusId
INNER JOIN (
		SELECT MAX(Id) as Id
		FROM dbo.RoomLog
		Group by roomId, StatusId 
) RLTop ON RL.Id = RLTop.Id  

--WHERE Convert(DATE, RL.TimeStamp) = Convert(Date, @Date) 

UPDATE #RoomLog
SET IsPrev = CASE WHEN TimeStamp IS NOT NULL THEN 1 ELSE 0 END
--, IsCurrent = CASE WHEN TimeStamp IS NOT NULL AND ToTimeStamp IS NULL THEN 1 ELSE 0 END
, IsNext = CASE WHEN TimeStamp IS NULL THEN 1 ELSE 0 END

UPDATE RL 
SET IsPrev = 0
, IsCurrent = 1
FROM #RoomLog RL 
INNER JOIN #Rooms R ON R.RoomId = RL.RoomId AND R.RoomStatusId = RL.RoomStatusId


  
SELECT * FROM #Rooms R ORDER BY RoomId asc, [TimeStamp] desc
SELECT * FROM #RoomLog ORDER BY RoomId, RoomStatusOrder  
  
DROP Table #Rooms                
DROP Table #RoomLog            
            
END   
  
  
  

GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatusWorkFlow]    Script Date: 14-07-2021 18:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUserPermissions]    Script Date: 14-07-2021 18:44:53 ******/
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
