USE [weavingplantdb]
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


