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