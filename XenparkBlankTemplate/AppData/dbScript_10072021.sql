USE [master]
GO
/****** Object:  Database [XenparkBlankDB]    Script Date: 10-07-2021 12:39:05 ******/
CREATE DATABASE [XenparkBlankDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'XenparkBlankDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\XenparkBlankDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'XenparkBlankDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\XenparkBlankDB_log.ldf' , SIZE = 270336KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [XenparkBlankDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [XenparkBlankDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [XenparkBlankDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [XenparkBlankDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [XenparkBlankDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [XenparkBlankDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [XenparkBlankDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET RECOVERY FULL 
GO
ALTER DATABASE [XenparkBlankDB] SET  MULTI_USER 
GO
ALTER DATABASE [XenparkBlankDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [XenparkBlankDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [XenparkBlankDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [XenparkBlankDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [XenparkBlankDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'XenparkBlankDB', N'ON'
GO
ALTER DATABASE [XenparkBlankDB] SET QUERY_STORE = OFF
GO
USE [XenparkBlankDB]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[BlockId] [int] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Batch]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[ProductId] [int] NULL,
	[BatchNumber] [varchar](200) NULL,
	[BatchSize] [int] NULL,
	[Status] [varchar](200) NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BatchLogger]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatchLogger](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NULL,
	[RoomId] [int] NULL,
	[TimeStamp] [datetime] NULL,
	[IsCompleted] [bit] NULL,
 CONSTRAINT [PK_BatchLogger] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Block]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[PlantId] [int] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Block] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Message] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[Source] [nvarchar](max) NULL,
	[TargetSite] [nvarchar](max) NULL,
	[userId] [int] NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Password] [varchar](100) NULL,
	[IncorrectAttempt] [int] NULL,
	[LastLogInTime] [datetime] NULL,
	[Blocked] [bit] NULL,
	[ForceChangePassword] [bit] NOT NULL,
 CONSTRAINT [PK_LoginInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[Id] [int] NOT NULL,
	[Title] [varchar](100) NULL,
	[Type] [varchar](50) NULL,
	[URL] [varchar](500) NULL,
	[Icon] [varchar](100) NULL,
	[Target] [bit] NULL,
	[Breadcrumbs] [bit] NULL,
	[Classes] [varchar](500) NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuPermission]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuPermission](
	[Id] [int] NOT NULL,
	[MenuId] [int] NULL,
	[PermissionId] [int] NULL,
 CONSTRAINT [PK_MenuPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[Id] [int] NOT NULL,
	[PermissionName] [varchar](500) NULL,
	[GroupName] [varchar](50) NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plant]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plant](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlantName] [varchar](100) NULL,
	[Location] [varchar](200) NULL,
	[Approved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](200) NULL,
	[Description] [varchar](500) NULL,
	[Active] [bit] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [ProductMaster_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](500) NULL,
	[SysRole] [bit] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[PermissionId] [int] NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[AreaId] [int] NULL,
	[Status] [varchar](200) NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomLog]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[StatusId] [int] NULL,
	[TimeStamp] [datetime] NULL,
 CONSTRAINT [PK_RoomLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusWorkFlow]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusWorkFlow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](100) NULL,
	[Order] [int] NULL,
	[IsFinal] [bit] NULL,
	[ProductProcessing] [bit] NULL,
 CONSTRAINT [PK_StatusWorkFlow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10-07-2021 12:39:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[UserName] [varchar](50) NULL,
	[RoleId] [int] NULL,
	[IsDisabled] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Area] ON 

INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (1, N'Area 1', N'Area 1', 1, 1)
SET IDENTITY_INSERT [dbo].[Area] OFF
GO
SET IDENTITY_INSERT [dbo].[Batch] ON 

INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (6, NULL, 8, N'B1001', 5000, N'Not Started', 10, CAST(N'2021-07-05T22:16:35.740' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (7, NULL, 2, N'B1002', 9000, N'Not Started', 10, CAST(N'2021-07-05T22:24:06.317' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (8, NULL, 4, N'B111', 333, N'Not Started', 10, CAST(N'2021-07-09T23:47:10.657' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (9, NULL, 8, N'C111', 2223, N'Not Started', 10, CAST(N'2021-07-09T23:48:23.430' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (10, NULL, 9, N'zazaza', 43, N'Not Started', 10, CAST(N'2021-07-09T23:48:44.080' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (11, NULL, 5, N'zzz', 12, N'Not Started', 10, CAST(N'2021-07-09T23:53:46.110' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (12, NULL, 10, N'ppp', 123, N'Not Started', 10, CAST(N'2021-07-09T23:54:07.233' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Batch] OFF
GO
SET IDENTITY_INSERT [dbo].[BatchLogger] ON 

INSERT [dbo].[BatchLogger] ([Id], [BatchId], [RoomId], [TimeStamp], [IsCompleted]) VALUES (11, 6, 1, CAST(N'2021-07-05T22:16:35.800' AS DateTime), 1)
INSERT [dbo].[BatchLogger] ([Id], [BatchId], [RoomId], [TimeStamp], [IsCompleted]) VALUES (12, 6, 3, CAST(N'2021-07-05T22:16:35.800' AS DateTime), 1)
INSERT [dbo].[BatchLogger] ([Id], [BatchId], [RoomId], [TimeStamp], [IsCompleted]) VALUES (13, 7, 3, CAST(N'2021-07-05T22:24:06.363' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[BatchLogger] OFF
GO
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Code], [Description], [PlantId], [Approved]) VALUES (1, N'Block1', N'Block 1 ', 1, 1)
INSERT [dbo].[Block] ([Id], [Code], [Description], [PlantId], [Approved]) VALUES (2, N'B2', N'B2', 2, 1)
SET IDENTITY_INSERT [dbo].[Block] OFF
GO
SET IDENTITY_INSERT [dbo].[ErrorLog] ON 

INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1, CAST(N'2021-05-01T22:16:39.173' AS DateTime), N'Could not find stored procedure ''sprocGetBatchInformation''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 54', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (2, CAST(N'2021-05-01T22:16:49.217' AS DateTime), N'Could not find stored procedure ''sprocGetBatchInformation''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 54', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (3, CAST(N'2021-05-07T19:31:41.217' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (4, CAST(N'2021-05-07T19:31:59.137' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (5, CAST(N'2021-05-07T19:39:20.897' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (6, CAST(N'2021-05-07T19:40:05.510' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (7, CAST(N'2021-05-07T19:40:11.580' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (8, CAST(N'2021-05-07T20:30:25.913' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (9, CAST(N'2021-05-07T20:30:28.037' AS DateTime), N'Column ''MachineId'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 60', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (10, CAST(N'2021-05-08T14:33:01.767' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (11, CAST(N'2021-05-08T14:33:30.167' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (12, CAST(N'2021-05-08T14:33:56.627' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (13, CAST(N'2021-05-08T14:34:35.017' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (14, CAST(N'2021-05-08T14:34:57.893' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (15, CAST(N'2021-05-08T14:36:17.680' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (16, CAST(N'2021-05-08T14:38:03.580' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (17, CAST(N'2021-05-08T14:57:14.000' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (18, CAST(N'2021-05-08T14:57:30.590' AS DateTime), N'Column ''Rent'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\xenparkblanktemplate\Controllers\DashboardController.cs:line 131', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (19, CAST(N'2021-05-12T11:22:45.020' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (20, CAST(N'2021-05-12T11:23:29.183' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (21, CAST(N'2021-05-12T11:23:45.410' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (22, CAST(N'2021-05-12T11:23:58.507' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (23, CAST(N'2021-05-12T11:24:43.243' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (24, CAST(N'2021-05-12T11:25:23.143' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (25, CAST(N'2021-05-12T11:29:22.587' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (26, CAST(N'2021-05-12T11:32:44.067' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (27, CAST(N'2021-05-12T11:52:06.927' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (28, CAST(N'2021-05-12T11:52:10.340' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (29, CAST(N'2021-05-12T17:56:45.383' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 62', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (30, CAST(N'2021-05-17T11:48:31.327' AS DateTime), N'Column ''#DownTime.DownTime'' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryHasMoreRows(Boolean& moreRows)
   at Microsoft.Data.SqlClient.SqlDataReader.TryReadInternal(Boolean setTimeout, Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.TryNextResult(Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
   at System.Data.Common.DataAdapter.FillNextResult(DataReaderContainer dataReader)
   at System.Data.Common.DataAdapter.FillFromReader(DataSet dataset, DataTable datatable, String srcTable, DataReaderContainer dataReader, Int32 startRecord, Int32 maxRecords, DataColumn parentChapterColumn, Object parentChapterValue)
   at System.Data.Common.DataAdapter.Fill(DataSet dataSet, String srcTable, IDataReader dataReader, Int32 startRecord, Int32 maxRecords)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (31, CAST(N'2021-05-17T11:57:28.470' AS DateTime), N'Column ''#DownTime.DownTime'' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryHasMoreRows(Boolean& moreRows)
   at Microsoft.Data.SqlClient.SqlDataReader.TryReadInternal(Boolean setTimeout, Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.TryNextResult(Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
   at System.Data.Common.DataAdapter.FillNextResult(DataReaderContainer dataReader)
   at System.Data.Common.DataAdapter.FillFromReader(DataSet dataset, DataTable datatable, String srcTable, DataReaderContainer dataReader, Int32 startRecord, Int32 maxRecords, DataColumn parentChapterColumn, Object parentChapterValue)
   at System.Data.Common.DataAdapter.Fill(DataSet dataSet, String srcTable, IDataReader dataReader, Int32 startRecord, Int32 maxRecords)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (32, CAST(N'2021-05-17T11:59:27.220' AS DateTime), N'Column ''#DownTime.DownTime'' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryHasMoreRows(Boolean& moreRows)
   at Microsoft.Data.SqlClient.SqlDataReader.TryReadInternal(Boolean setTimeout, Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.TryNextResult(Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
   at System.Data.Common.DataAdapter.FillNextResult(DataReaderContainer dataReader)
   at System.Data.Common.DataAdapter.FillFromReader(DataSet dataset, DataTable datatable, String srcTable, DataReaderContainer dataReader, Int32 startRecord, Int32 maxRecords, DataColumn parentChapterColumn, Object parentChapterValue)
   at System.Data.Common.DataAdapter.Fill(DataSet dataSet, String srcTable, IDataReader dataReader, Int32 startRecord, Int32 maxRecords)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (33, CAST(N'2021-05-17T12:00:46.567' AS DateTime), N'Column ''#DownTime.DownTime'' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryHasMoreRows(Boolean& moreRows)
   at Microsoft.Data.SqlClient.SqlDataReader.TryReadInternal(Boolean setTimeout, Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.TryNextResult(Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
   at System.Data.Common.DataAdapter.FillNextResult(DataReaderContainer dataReader)
   at System.Data.Common.DataAdapter.FillFromReader(DataSet dataset, DataTable datatable, String srcTable, DataReaderContainer dataReader, Int32 startRecord, Int32 maxRecords, DataColumn parentChapterColumn, Object parentChapterValue)
   at System.Data.Common.DataAdapter.Fill(DataSet dataSet, String srcTable, IDataReader dataReader, Int32 startRecord, Int32 maxRecords)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Umesh_Work\xenpark-blank-template\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (34, CAST(N'2021-05-24T18:04:14.257' AS DateTime), N'Procedure or function ''sprocGetBatchInformation'' expects parameter ''@MachineId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (35, CAST(N'2021-05-24T18:04:22.950' AS DateTime), N'Procedure or function ''sprocGetBatchInformation'' expects parameter ''@MachineId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (36, CAST(N'2021-05-24T18:05:27.713' AS DateTime), N'Procedure or function ''sprocGetBatchInformation'' expects parameter ''@MachineId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(String period) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (37, CAST(N'2021-06-01T01:25:53.390' AS DateTime), N'Column ''MachineStatus'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 146', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (38, CAST(N'2021-06-01T01:26:08.370' AS DateTime), N'Column ''MachineStatus'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 146', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (39, CAST(N'2021-06-01T01:26:59.040' AS DateTime), N'Column ''MachineStatus'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 146', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (40, CAST(N'2021-06-01T01:30:17.540' AS DateTime), N'Column ''StopTimeStamp'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 154', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (41, CAST(N'2021-06-01T01:32:28.343' AS DateTime), N'Column ''StopTimeStamp'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 154', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (42, CAST(N'2021-06-01T13:00:59.667' AS DateTime), N'Column ''StopTimeStamp'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 154', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (43, CAST(N'2021-06-01T13:04:00.487' AS DateTime), N'Column ''StopTimeStamp'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 154', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (44, CAST(N'2021-06-13T14:44:20.330' AS DateTime), N'Could not find stored procedure ''sprocAddEditMaster''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\MasterController.cs:line 100', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (45, CAST(N'2021-06-13T14:45:20.210' AS DateTime), N'Could not find stored procedure ''sprocGetMaster''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\MasterController.cs:line 54', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (46, CAST(N'2021-06-13T14:45:27.157' AS DateTime), N'Could not find stored procedure ''sprocAddEditMaster''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\MasterController.cs:line 100', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (47, CAST(N'2021-06-13T14:45:36.680' AS DateTime), N'Could not find stored procedure ''sprocGetMaster''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\MasterController.cs:line 54', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (48, CAST(N'2021-06-18T20:12:17.093' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (49, CAST(N'2021-06-18T20:12:17.093' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (50, CAST(N'2021-06-18T20:12:25.557' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (51, CAST(N'2021-06-18T20:12:27.973' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (52, CAST(N'2021-06-18T20:13:08.990' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (53, CAST(N'2021-06-18T20:13:10.167' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (54, CAST(N'2021-06-18T20:13:11.570' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (55, CAST(N'2021-06-18T20:15:38.560' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (56, CAST(N'2021-06-18T20:15:39.020' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (57, CAST(N'2021-06-18T20:15:40.980' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (58, CAST(N'2021-06-18T20:17:15.837' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (59, CAST(N'2021-06-18T20:17:19.943' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (60, CAST(N'2021-06-18T20:17:26.833' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (61, CAST(N'2021-06-18T20:19:19.030' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (62, CAST(N'2021-06-18T20:20:29.060' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (63, CAST(N'2021-06-18T20:20:40.360' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (64, CAST(N'2021-06-18T20:21:21.947' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (65, CAST(N'2021-06-18T20:22:33.740' AS DateTime), N'Column ''HaltTime'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 165', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (66, CAST(N'2021-06-18T20:28:50.240' AS DateTime), N'There is no row at position 0.', N'   at System.Data.RBTree`1.GetNodeByIndex(Int32 userIndex)
   at System.Data.DataRowCollection.get_Item(Int32 index)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 177', N'System.Data.Common', N'NodePath GetNodeByIndex(Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (67, CAST(N'2021-06-18T21:45:33.503' AS DateTime), N'Invalid column name ''BI''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryHasMoreRows(Boolean& moreRows)
   at Microsoft.Data.SqlClient.SqlDataReader.TryReadInternal(Boolean setTimeout, Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.TryNextResult(Boolean& more)
   at Microsoft.Data.SqlClient.SqlDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
   at System.Data.Common.DataAdapter.FillNextResult(DataReaderContainer dataReader)
   at System.Data.Common.DataAdapter.FillFromReader(DataSet dataset, DataTable datatable, String srcTable, DataReaderContainer dataReader, Int32 startRecord, Int32 maxRecords, DataColumn parentChapterColumn, Object parentChapterValue)
   at System.Data.Common.DataAdapter.Fill(DataSet dataSet, String srcTable, IDataReader dataReader, Int32 startRecord, Int32 maxRecords)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\XenparkBlankTemplate\XenparkBlankTemplate\Controllers\DashboardController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (68, CAST(N'2021-06-26T18:51:50.930' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (69, CAST(N'2021-06-26T18:53:15.733' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (70, CAST(N'2021-06-26T20:03:55.397' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (71, CAST(N'2021-06-26T20:10:04.033' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (72, CAST(N'2021-06-26T21:05:13.437' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (73, CAST(N'2021-06-26T21:06:02.967' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (74, CAST(N'2021-06-26T21:07:12.283' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (75, CAST(N'2021-06-26T21:31:24.430' AS DateTime), N'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.', N'   at System.Convert.FromBase64CharPtr(Char* inputPtr, Int32 inputLength)
   at System.Convert.FromBase64String(String s)
   at XenparkBlankTemplate.Helper.EncryptDecryptHelper.DecryptStringAES(String encryptedText) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Helper\EcryptDecryptHelper.cs:line 22
   at XenparkBlankTemplate.Controllers.UserController.Authenticate(LoggedInUser model) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 50', N'System.Private.CoreLib', N'Byte[] FromBase64CharPtr(Char*, Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1069, CAST(N'2021-07-01T11:29:50.530' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@RoomId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 99', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1070, CAST(N'2021-07-01T11:37:25.693' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@RoomId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 99', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1071, CAST(N'2021-07-01T11:38:16.183' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@RoomId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 99', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1072, CAST(N'2021-07-01T11:43:58.173' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@Status'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 100', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1073, CAST(N'2021-07-01T11:46:02.830' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@Status'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 100', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1074, CAST(N'2021-07-01T17:55:29.873' AS DateTime), N'Procedure or function ''sprocAddEditUser'' expects parameter ''@Email'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.UserController.MaintainUser(User user, String password) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\UserController.cs:line 140', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1075, CAST(N'2021-07-01T20:43:55.757' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 64', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1076, CAST(N'2021-07-01T20:49:34.607' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 64', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1077, CAST(N'2021-07-01T20:50:20.213' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 64', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1078, CAST(N'2021-07-01T21:16:32.977' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 64', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1079, CAST(N'2021-07-01T21:18:11.123' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 64', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1080, CAST(N'2021-07-01T21:40:36.163' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDateTime(IFormatProvider provider)
   at System.Convert.ToDateTime(Object value)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 73', N'System.Private.CoreLib', N'System.DateTime System.IConvertible.ToDateTime(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1081, CAST(N'2021-07-02T11:32:13.457' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDateTime(IFormatProvider provider)
   at System.Convert.ToDateTime(Object value)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 89', N'System.Private.CoreLib', N'System.DateTime System.IConvertible.ToDateTime(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1082, CAST(N'2021-07-02T11:37:52.027' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDateTime(IFormatProvider provider)
   at System.Convert.ToDateTime(Object value)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 89', N'System.Private.CoreLib', N'System.DateTime System.IConvertible.ToDateTime(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1083, CAST(N'2021-07-02T17:09:29.413' AS DateTime), N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_RoomLog_Room". The conflict occurred in database "XenparkBlankDB", table "dbo.Room", column ''Id''.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.RoomController.ChangeRoomStatus(Int32 roomId, Int32 statusId) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoomController.cs:line 185', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1084, CAST(N'2021-07-05T01:37:09.020' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@RoomIds'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 119', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1085, CAST(N'2021-07-09T10:51:35.987' AS DateTime), N'Cannot find table 1.', N'   at System.Data.DataTableCollection.get_Item(Int32 index)
   at XenparkBlankTemplate.Controllers.RoleController.GetRoles() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoleController.cs:line 65', N'System.Data.Common', N'System.Data.DataTable get_Item(Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1086, CAST(N'2021-07-09T10:54:53.580' AS DateTime), N'Cannot find table 1.', N'   at System.Data.DataTableCollection.get_Item(Int32 index)
   at XenparkBlankTemplate.Controllers.RoleController.GetRoles() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoleController.cs:line 65', N'System.Data.Common', N'System.Data.DataTable get_Item(Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1087, CAST(N'2021-07-09T10:55:46.027' AS DateTime), N'Cannot find table 1.', N'   at System.Data.DataTableCollection.get_Item(Int32 index)
   at XenparkBlankTemplate.Controllers.RoleController.GetRoles() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoleController.cs:line 65', N'System.Data.Common', N'System.Data.DataTable get_Item(Int32)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1088, CAST(N'2021-07-09T19:07:44.097' AS DateTime), N'Column ''Approved'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 65', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1089, CAST(N'2021-07-09T19:09:00.457' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToBoolean(IFormatProvider provider)
   at System.Convert.ToBoolean(Object value)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 65', N'System.Private.CoreLib', N'Boolean System.IConvertible.ToBoolean(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1090, CAST(N'2021-07-09T19:09:47.267' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToBoolean(IFormatProvider provider)
   at System.Convert.ToBoolean(Object value)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 65', N'System.Private.CoreLib', N'Boolean System.IConvertible.ToBoolean(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1091, CAST(N'2021-07-09T19:21:02.200' AS DateTime), N'Column ''Approved'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at System.Data.DataRowExtensions.Field[T](DataRow row, String columnName)
   at XenparkBlankTemplate.Controllers.RoleController.GetRoles() in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\RoleController.cs:line 62', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginInfo] ON 

INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (10, 10, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (11, 11, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (12, 12, N'Y27w6pG8PJkzbBPtAGluxg==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (13, 13, N'BwT9DLfsF3b4cTbfFWe02Q==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (14, 14, N'WM0rsqrPHFjWKqKEanJpaw==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (15, 15, N'nSXMhfIRzlashw/8vuzMow==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (16, 16, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (17, 17, N'aJX3jz/7VJ9roqOGSRVPug==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (18, 18, N'tEtefokn72ebP6gL4L2ihQ==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (19, 19, N'fRFFY7t9OfDm+FGU+zi8lA==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (20, 20, N'nguxTECuIDTQITenFlr07g==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (21, 21, N'ngbwfTbptTHOoMOIVj0OSg==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (22, 22, N'12345', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (23, 23, N'12345', 0, NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[LoginInfo] OFF
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (1, N' ', N'group', NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (2, N'Dashboard', N'item', N'/room-list', N'feather icon-monitor', NULL, 0, NULL, 1)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (3, N'Manage Batch', N'item', N'/batch', N'feather icon-layout', NULL, 0, NULL, 1)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (4, N'Manage Users', N'item', N'/user', N'feather icon-user', NULL, 0, NULL, 1)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (5, N'System Setup', N'collapse', NULL, N'feather icon-settings', NULL, 0, NULL, 1)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (6, N'Plant', N'item', N'/plant-master', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (7, N'Block', N'item', N'/block-master', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (8, N'Area', N'item', N'/area-master', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (9, N'Room', N'item', N'/room-master', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (10, N'Product', N'item', N'/product-master', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (11, N'Workflow', N'item', N'/workflow', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (12, N'Role', N'item', N'/role', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (1, 4, 1)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (2, 4, 2)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (3, 12, 4)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (4, 12, 5)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (5, 2, 7)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (6, 6, 8)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (7, 6, 9)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (8, 7, 11)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (9, 7, 12)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (10, 8, 14)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (11, 8, 15)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (12, 9, 17)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (13, 9, 18)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (14, 10, 20)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (15, 10, 21)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (16, 11, 23)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (17, 11, 24)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (18, 3, 26)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (19, 3, 27)
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (1, N'Add/Edit Users', N'Manage Users')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (2, N'View Users', N'Manage Users')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (3, N'Delete Users', N'Manage Users')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (4, N'Add/Edit Roles and Permissions', N'Manage Roles')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (5, N'View Roles and Permissions', N'Manage Roles')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (6, N'Delete Roles and Permissions', N'Manage Roles')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (7, N'View Dashboard', N'Dashboard')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (8, N'Add/Edit Plant', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (9, N'View Plant', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (10, N'Delete Plant', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (11, N'Add/Edit Block', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (12, N'View Block', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (13, N'Delete Block', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (14, N'Add/Edit Area', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (15, N'View Area', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (16, N'Delete Area', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (17, N'Add/Edit Room', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (18, N'View Room', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (19, N'Delete Room', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (20, N'Add/Edit Product', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (21, N'View Product', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (22, N'Delete Product', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (23, N'Add/Edit Workflow', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (24, N'View Workflow', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (25, N'Delete Workflow', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (26, N'Add/Edit Batch', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (27, N'View Batch', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (28, N'Delete Batch', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (29, N'Assign Batch to Room', N'Dashboard')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (30, N'Change Batch Status', N'Dashboard')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (31, N'Approve Masters', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (32, N'Create and Assigned Batch', N'Dashboard')
GO
SET IDENTITY_INSERT [dbo].[Plant] ON 

INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (1, N'Indore', N'Indore', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (2, N'Dewas Note Press', N'Dewas', 1)
SET IDENTITY_INSERT [dbo].[Plant] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductMaster] ON 

INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (1, N'P001', N'Paracetamol', 1, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (2, N'P002', N'Abacavir', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (3, N'P003', N'Baclofen', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (4, N'P004', N'Cephalexin', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (5, N'P005', N'Daunorubicin', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (6, N'P006', N'Enoxaparin', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (7, N'P007', N'G-CSF (Filgrastim)', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (8, N'P008', N'Hydrocortisone
', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (9, N'P009', N'Moov', NULL, NULL)
INSERT [dbo].[ProductMaster] ([Id], [Code], [Description], [Active], [Approved]) VALUES (10, N'test2', N'test', NULL, NULL)
SET IDENTITY_INSERT [dbo].[ProductMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (1, N'Manager', N'Manager', 0, 1)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (2, N'Supervisor', N'Supervisor', 0, 1)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (3, N'Operator', N'Operator', 0, 1)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (4, N'System Admin', N'System Admin', 1, 0)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[RolePermission] ON 

INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (1, 1, 1)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (2, 1, 2)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (3, 1, 3)
SET IDENTITY_INSERT [dbo].[RolePermission] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved]) VALUES (1, N'101', N'Blending', 1, NULL, 1)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved]) VALUES (2, N'102', N'Granulation', 1, NULL, 1)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved]) VALUES (3, N'103', N'Drying', 1, NULL, 1)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved]) VALUES (4, N'104', N'Compaction', 1, NULL, 1)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved]) VALUES (5, N'105', N'Coating', 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomLog] ON 

INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (136, 1, 1, CAST(N'2021-07-05T22:16:35.850' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (137, 3, 1, CAST(N'2021-07-05T22:16:35.850' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (138, 1, 2, CAST(N'2021-07-05T22:18:31.853' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (139, 1, 3, CAST(N'2021-07-05T22:21:38.263' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (140, 1, 3, CAST(N'2021-07-05T22:21:41.643' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (141, 1, 4, CAST(N'2021-07-05T22:21:46.850' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (142, 1, 1, CAST(N'2021-07-05T22:21:52.583' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (143, 1, 2, CAST(N'2021-07-05T22:22:11.023' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (144, 1, 3, CAST(N'2021-07-05T22:22:12.127' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (145, 3, 2, CAST(N'2021-07-05T22:24:23.270' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (146, 3, 3, CAST(N'2021-07-05T22:24:26.993' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (147, 3, 4, CAST(N'2021-07-05T22:24:29.973' AS DateTime))
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp]) VALUES (148, 3, 1, CAST(N'2021-07-05T22:24:35.250' AS DateTime))
SET IDENTITY_INSERT [dbo].[RoomLog] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] ON 

INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (1, N'Ready for Use', 1, 0, 0)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (2, N'Prod. In Process', 2, 0, 1)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (3, N'Cleaning', 3, 0, 0)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (4, N'Maintenance', 4, 1, 0)
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (10, N'D', N'C', N'choudharydeepak2007@gmail.com', N'a', 1, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (11, N'D', N'C', N'krrishchdhry@gmail.com', N'dc', 4, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (12, N'DeepakC', N'Ch', N'deepak.choudhary@xenpark.com', N'dc101', 4, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (13, N'Bharat', N'Kourav1', N'bharatkourav@gmail.com', N'doctor', 3, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (14, N'Shubham', N'Hospital', N'sh@gmail.com', N'clinic', 4, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (15, N'Umesh', N'Bakre', N'ubakre@gmail.com', N'ubakre', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (16, N'John', N'Doe', N'j.doe@gmail.com', N'jdoe', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (17, N'Mark', N'Malaaaap', N'maletich33@gmail.com', N'mark', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (18, N'K', N'A', N'ka@gmail.com', N'ka', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (19, N'zaza', N'zazaz', N'zazaza@xsxs.cd', N'zazazaz', 3, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (20, N'aqwe', N'qae', N'wqew@asd.cdvf', N'xsxsxs', 4, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (21, N'l', N'l', N'l@l.l', N'l', 3, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (22, N'supervisor', N'supervisor', N'john@gmail.com', N'aa', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (23, N'Kunal', N'A', N'kayachit@gmail.com', N'kayachit', 1, 0, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[LoginInfo] ADD  CONSTRAINT [DF_LoginInfo_IncorrectAttempt]  DEFAULT ((0)) FOR [IncorrectAttempt]
GO
ALTER TABLE [dbo].[LoginInfo] ADD  CONSTRAINT [DF_LoginInfo_Blocked]  DEFAULT ((0)) FOR [Blocked]
GO
ALTER TABLE [dbo].[LoginInfo] ADD  DEFAULT ((0)) FOR [ForceChangePassword]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_ProductMaster] FOREIGN KEY([ProductId])
REFERENCES [dbo].[ProductMaster] ([Id])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_ProductMaster]
GO
ALTER TABLE [dbo].[BatchLogger]  WITH CHECK ADD  CONSTRAINT [FK_BatchLogger_Batch] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([Id])
GO
ALTER TABLE [dbo].[BatchLogger] CHECK CONSTRAINT [FK_BatchLogger_Batch]
GO
ALTER TABLE [dbo].[BatchLogger]  WITH CHECK ADD  CONSTRAINT [FK_BatchLogger_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([Id])
GO
ALTER TABLE [dbo].[BatchLogger] CHECK CONSTRAINT [FK_BatchLogger_Room]
GO
ALTER TABLE [dbo].[Block]  WITH CHECK ADD  CONSTRAINT [FK_Block_Plant] FOREIGN KEY([PlantId])
REFERENCES [dbo].[Plant] ([Id])
GO
ALTER TABLE [dbo].[Block] CHECK CONSTRAINT [FK_Block_Plant]
GO
ALTER TABLE [dbo].[LoginInfo]  WITH CHECK ADD  CONSTRAINT [FK_LoginInfo_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[LoginInfo] CHECK CONSTRAINT [FK_LoginInfo_User]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Area] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([Id])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Area]
GO
ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_RoomLog_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([Id])
GO
ALTER TABLE [dbo].[RoomLog] CHECK CONSTRAINT [FK_RoomLog_Room]
GO
ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_RoomLog_StatusWorkFlow] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusWorkFlow] ([Id])
GO
ALTER TABLE [dbo].[RoomLog] CHECK CONSTRAINT [FK_RoomLog_StatusWorkFlow]
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditBatch]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE Procedure [dbo].[sprocAddEditBatch]  
@Id     INT  
,@RoomIds   VARCHAR(MAX)
,@ProductId   INT  
,@BatchNumber  VARCHAR(200)  
,@BatchSize   INT  
,@Status   VARCHAR(200)  
,@UserId            INT  
  
AS  
BEGIN  
  DECLARE @INSERTEDBatchId INT = -1;
  IF(ISNULL(@Id,0) < 1)  
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
     
    --Now add record in batch log  
     
    END  
  ELSE  
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
  END 
  
  IF LEN(@RoomIds) > 0
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sprocAddEditMaster]
@Id          INT,
@Code	     VARCHAR(100),
@Description VARCHAR(50),
@ParentId    int,
@Type		 VARCHAR(50)

AS
BEGIN

  IF(ISNULL(@Id,0) < 1)
  BEGIN
   IF(@Type = 'product')
	BEGIN
	  IF NOT EXISTS(SELECT 'x' FROM [ProductMaster] WHERE code = @Code)
	  BEGIN
			INSERT INTO [ProductMaster] (Code, Description)
			VALUES (@Code, @Description)
	  END
	END
	IF(@Type = 'plant')
	BEGIN
	    IF NOT EXISTS(SELECT 'x' FROM [Plant] WHERE PlantName = @Code)
	    BEGIN
			INSERT INTO [Plant] (PlantName, Location)
			VALUES (@Code, @Description)
	    END
	END
	IF(@Type = 'block')
	BEGIN
	   IF NOT EXISTS(SELECT 'x' FROM [Block] WHERE Code = @Code)
	    BEGIN
			INSERT INTO [Block] (Code, Description, PlantId)
			VALUES (@Code, @Description, @ParentId)
		END
	END
	IF(@Type = 'area')
	BEGIN
	  IF NOT EXISTS(SELECT 'x' FROM [Area] WHERE Code = @Code)
	    BEGIN
			INSERT INTO [Area] (Code, Description, BlockId)
			VALUES (@Code, @Description, @ParentId)
      END
	END
	IF(@Type = 'room')
	BEGIN
	   IF NOT EXISTS(SELECT 'x' FROM [Room] WHERE Code = @Code)
	    BEGIN
			INSERT INTO [Room] (Code, Description, AreaId, Status)
			VALUES (@Code, @Description, @ParentId,null)
		END
	END
  END
  ELSE
  BEGIN
   IF(@Type = 'product')
	BEGIN
			UPDATE X SET	  Code = @Code,
							  [Description] = @Description
			FROM [ProductMaster] X
			WHERE Id= @Id
	END
	IF(@Type = 'plant')
	BEGIN
			UPDATE X SET	  PlantName = @Code,
							  [Location] = @Description
			FROM [Plant] X
			WHERE Id= @Id
	END
	IF(@Type = 'block')
	BEGIN
			UPDATE X SET	  Code = @Code,
							  [Description] = @Description,
							  plantId = @ParentId
			FROM [Block] X
			WHERE Id= @Id
	END
	IF(@Type = 'area')
	BEGIN
			UPDATE X SET	  Code = @Code,
							  [Description] = @Description,
							  BlockId = @ParentId
			FROM [Area] X
			WHERE Id= @Id
	END
	IF(@Type = 'room')
	BEGIN
			UPDATE X SET	  Code = @Code,
							  [Description] = @Description,
							  AreaId = @ParentId
			FROM [Room] X
			WHERE Id= @Id
	END
   

  END
END
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditRolePermission]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[sprocAddEditRolePermission]
@RoleId INT,
@PermissionIds varchar(1000),
@RoleName VARCHAR(100),
@RoleDescription VARCHAR(500)
AS
DECLARE @Id INT
IF @RoleId = 0
BEGIN
  INSERT INTO [Role] (Name,Description,SysRole)
  VALUES(@RoleName, @RoleDescription,0)
  SET @Id = SCOPE_IDENTITY()

  INSERT INTO RolePermission(RoleId,PermissionId)
  SELECT @id,lngId FROM dbo.fn_GetIds(@PermissionIds)
END
ELSE
BEGIN
  DELETE FROM RolePermission WHERE RoleId = @RoleId

  UPDATE Role 
    SET Name=  @RoleName,
	    Description = @RoleDescription
  WHERE Id =@RoleId

  INSERT INTO RolePermission(RoleId,PermissionId)
  SELECT @RoleId,lngId FROM dbo.fn_GetIds(@PermissionIds)

END

GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditUser]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocApproveMaster]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAssignBatchToRoom]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE Procedure [dbo].[sprocAssignBatchToRoom]  
@BatchId INT  
,@RoomId INT  
AS  
BEGIN  
 -- Create a record in BatchLogger  
INSERT INTO dbo.BatchLogger(BatchId, RoomId, [TimeStamp])  
SELECT @BatchId, @RoomId, GETDATE()  
WHERE NOT EXISTS (SELECT 1 FROM BatchLogger WHERE BatchId = @BatchId AND RoomId = @RoomId)

-- Create a record in RoomLog If No Record for Room  
DECLARE @Status INT   
SELECT TOP 1 @Status = Id From dbo.StatusWorkFlow Where [Order] = 1   
INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp])  
SELECT  @RoomId, @Status, GETDATE()
WHERE NOT EXISTS (SELECT 1 FROM RoomLog WHERE RoomId = @RoomId)
  
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetBatch]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[sprocGetBatch]

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
  FROM [dbo].[Batch]CT 

SELECT Id,
       BatchId,
       RoomId,
       TimeStamp
FROM BatchLogger
END


GO
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE Procedure [dbo].[sprocGetMaster]  
@Type   VARCHAR(50),  
@ParentId  INT = 0  
  
AS  
BEGIN  
  
  IF(@Type = 'plant')  
 BEGIN  
   SELECT Id as Id,   
   PlantName as Code,  
   Location as Description,  
   ParentId = 0,  
   ParentDescription = '', 
   ISNULL(Approved,0) AS Approved
   From Plant  
  
 END  
 IF(@Type = 'block')  
 BEGIN  
   SELECT B.Id,   
   Code,  
   Description,  
   PlantId as ParentId,  
   PlantName as ParentDescription , 
   ISNULL(B.Approved,0) AS Approved 
   From Block B   
   INNER JOIN Plant P on P.Id = B.PlantId  
   WHERE @ParentId = 0 OR B.PlantId = @ParentId   
 END  
 IF(@Type = 'area')  
 BEGIN  
   SELECT A.Id,   
   A.Code,  
   A.Description,  
   A.BlockId as ParentId,  
   B.Description as ParentDescription, 
   ISNULL(A.Approved,0) AS Approved  
   From Area A  
   INNER JOIN Block B on B.Id = A.BlockId  
   WHERE @ParentId = 0 OR A.BlockId = @ParentId   
 END  
 IF(@Type = 'room')  
 BEGIN  
   SELECT R.Id,   
   R.Code,  
   R.Description,  
   R.AreaId as ParentId,  
   A.Description as ParentDescription , 
   ISNULL(R.Approved,0) AS Approved 
   From Room R  
   INNER JOIN Area A on A.Id = R.AreaId  
   WHERE @ParentId = 0 OR R.AreaId = @ParentId   
 END 
 IF(@Type = 'product')  
 BEGIN  
   SELECT P.Id,   
   P.Code,  
   P.Description,  
   0 as ParentId,  
   '' as ParentDescription , 
   ISNULL(P.Approved,0) AS Approved
   From ProductMaster P  
 END 
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetMenus]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetMenus]  
@UserId   INT  
AS  
BEGIN
  SELECT Id
        ,Title
        ,Type
        ,URL
        ,Icon
        ,Target
        ,Breadcrumbs
        ,Classes
        ,ISNULL(ParentId,0) AS ParentId
  FROM Menu

END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetPermissions]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoles]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetRoles]  
AS  
BEGIN
  SELECT Id
        ,[Name]
        ,[Description]
        ,ISNULL(SysRole,0) AS SysRole
        ,ISNULL(Approved,0) AS Approved
  FROM [Role]

  SELECT Id, PermissionId,RoleId
  FROM RolePermission
  

END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomMaster]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 10-07-2021 12:39:07 ******/
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
  [TimeStamp]  DATETIME  
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
  ,RoomDesc)  
SELECT R.Id,R.Code,R.Description 
FROM Room R
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatusWorkFlow]    Script Date: 10-07-2021 12:39:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUserPermissions]    Script Date: 10-07-2021 12:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE Procedure [dbo].[sprocGetUserPermissions]  
@UserId   INT  
AS  
BEGIN
  SELECT *
  FROM [User] U
  INNER JOIN [Role] R ON U.RoleId = R.Id
  INNER JOIN RolePermission RP ON RP.RoleId = R.Id
  INNER JOIN Permission P ON RP.PermissionId = P.Id
  WHERE U.Id = @UserId

END  
  
  
GO
USE [master]
GO
ALTER DATABASE [XenparkBlankDB] SET  READ_WRITE 
GO
