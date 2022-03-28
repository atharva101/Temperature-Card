
ALTER Procedure [dbo].[sprocAddEditUser]
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
USE [RoomStatus]
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 3/26/2022 1:42:16 PM ******/
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