USE [master]
GO
/****** Object:  Database [weavingplantdb]    Script Date: 25-03-2022 22:26:18 ******/
CREATE DATABASE [weavingplantdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'weavingplantdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER03\MSSQL\DATA\weavingplantdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'weavingplantdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER03\MSSQL\DATA\weavingplantdb_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [weavingplantdb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [weavingplantdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [weavingplantdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [weavingplantdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [weavingplantdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [weavingplantdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [weavingplantdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [weavingplantdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [weavingplantdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [weavingplantdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [weavingplantdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [weavingplantdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [weavingplantdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [weavingplantdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [weavingplantdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [weavingplantdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [weavingplantdb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [weavingplantdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [weavingplantdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [weavingplantdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [weavingplantdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [weavingplantdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [weavingplantdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [weavingplantdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [weavingplantdb] SET RECOVERY FULL 
GO
ALTER DATABASE [weavingplantdb] SET  MULTI_USER 
GO
ALTER DATABASE [weavingplantdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [weavingplantdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [weavingplantdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [weavingplantdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [weavingplantdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [weavingplantdb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'weavingplantdb', N'ON'
GO
ALTER DATABASE [weavingplantdb] SET QUERY_STORE = OFF
GO
USE [weavingplantdb]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Batch]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[ReferenceNumber] [varchar](100) NULL,
	[FormNumber] [varchar](100) NULL,
	[VersionNumber] [varchar](100) NULL,
	[PlantId] [int] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Block] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[MenuPermission]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[mylan_ProductMaster]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mylan_ProductMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](200) NULL,
	[Description] [varchar](2000) NULL,
	[UOM] [int] NULL,
	[Active] [bit] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [mylan_ProductMaster_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mylan_UnitOfMeasure]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mylan_UnitOfMeasure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[Approved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Plant]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[RolePermission]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 25-03-2022 22:26:18 ******/
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
	[DeviceIPAddress] [varchar](20) NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomLog]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[StatusId] [int] NULL,
	[TimeStamp] [datetime] NULL,
	[BatchId] [int] NULL,
	[BatchSize] [int] NULL,
	[UOM] [int] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_RoomLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusWorkFlow]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[UnitOfMesurementMaster]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitOfMesurementMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[DelStatus] [bit] NULL,
	[AddedBy] [int] NULL,
	[AddedOn] [datetime] NULL,
	[LastUpBy] [int] NULL,
	[LastUpOn] [datetime] NULL,
 CONSTRAINT [PK_UnitOfMesurementMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 25-03-2022 22:26:18 ******/
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
/****** Object:  Table [dbo].[UserRoom]    Script Date: 25-03-2022 22:26:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoomId] [int] NULL,
 CONSTRAINT [PK_UserRoom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Area] ON 

INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (1, N'Process Room', N'Process Room', 1, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (2, N'Granulation', N'Granulation', 1, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (3, N'Packing', N'Packing', 1, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (4, N'Coating', N'Coating', 1, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (5, N'Compression', N'Compression', 1, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (6, N'', N'aa12', 2, 1)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (7, N'7', N'1', 2, 0)
INSERT [dbo].[Area] ([Id], [Code], [Description], [BlockId], [Approved]) VALUES (8, N'8', N'2', 2, 0)
SET IDENTITY_INSERT [dbo].[Area] OFF
GO
SET IDENTITY_INSERT [dbo].[Batch] ON 

INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (18, NULL, 2, N'B1001', 1000, N'Not Started', 25, CAST(N'2022-03-25T10:36:30.080' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (19, NULL, 6, N'B1002', 5000, N'Not Started', 25, CAST(N'2022-03-25T12:06:02.557' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Batch] ([Id], [RoomId], [ProductId], [BatchNumber], [BatchSize], [Status], [AddedBy], [AddedOn], [UpdatedBy], [UpdatedOn], [Approved]) VALUES (20, NULL, 1, N'B1003', 2000, N'Not Started', 25, CAST(N'2022-03-25T12:44:29.663' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Batch] OFF
GO
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (1, N'Block - A', N'Block - A', N'1', N'11', N'111', 1, 0)
INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (2, N'Block - B', N'Block - B', NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (3, N'Block - C', N'Block - C', NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (4, N'', N'Numbers', N'aaaa', N'zzzz', N'111', 1, 0)
INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (5, N'7', N'1', N'1', N'1', N'1', 1, 0)
INSERT [dbo].[Block] ([Id], [Code], [Description], [ReferenceNumber], [FormNumber], [VersionNumber], [PlantId], [Approved]) VALUES (6, N'7', N'2', N'2', N'2', N'2', 2, 0)
SET IDENTITY_INSERT [dbo].[Block] OFF
GO
SET IDENTITY_INSERT [dbo].[ErrorLog] ON 

INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (1, CAST(N'2021-07-22T21:40:14.243' AS DateTime), N'An exception has been raised that is likely due to a transient failure. Consider enabling transient error resiliency by adding ''EnableRetryOnFailure()'' to the ''UseSqlServer'' call.', N'   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at System.Linq.Enumerable.SingleOrDefault[TSource](IEnumerable`1 source)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.Execute[TResult](Expression query)
   at Microsoft.EntityFrameworkCore.Query.Internal.EntityQueryProvider.Execute[TResult](Expression expression)
   at System.Linq.Queryable.FirstOrDefault[TSource](IQueryable`1 source)
   at XenparkBlankTemplate.Controllers.UserController.Me() in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\UserController.cs:line 68', N'Microsoft.EntityFrameworkCore.SqlServer', N'TResult Execute[TState,TResult](TState, System.Func`3[Microsoft.EntityFrameworkCore.DbContext,TState,TResult], System.Func`3[Microsoft.EntityFrameworkCore.DbContext,TState,Microsoft.EntityFrameworkCore.Storage.ExecutionResult`1[TResult]])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (2, CAST(N'2021-07-23T13:51:03.563' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (3, CAST(N'2021-07-23T13:51:04.050' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (4, CAST(N'2021-07-23T13:51:05.943' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (5, CAST(N'2021-07-23T13:51:15.913' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (6, CAST(N'2021-07-23T13:51:20.310' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (7, CAST(N'2021-07-23T13:51:27.333' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (8, CAST(N'2021-07-23T13:52:51.087' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (9, CAST(N'2021-07-23T13:53:47.637' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (10, CAST(N'2021-07-23T13:53:51.853' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (11, CAST(N'2021-07-23T13:53:56.460' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (12, CAST(N'2021-07-23T13:54:32.117' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (13, CAST(N'2021-07-26T16:51:16.830' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (14, CAST(N'2021-07-26T16:51:17.387' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (15, CAST(N'2021-07-26T16:51:21.123' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (16, CAST(N'2021-07-26T16:51:23.987' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (17, CAST(N'2021-07-26T16:51:33.033' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (18, CAST(N'2021-07-26T16:52:06.343' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (19, CAST(N'2021-07-26T16:52:17.680' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (20, CAST(N'2021-07-26T16:52:20.730' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (21, CAST(N'2021-07-26T16:53:19.680' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (22, CAST(N'2021-07-26T16:53:28.877' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (23, CAST(N'2021-07-26T16:53:53.850' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (24, CAST(N'2021-07-26T16:53:55.247' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (25, CAST(N'2021-07-26T16:54:39.893' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (26, CAST(N'2021-07-26T16:54:41.930' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (27, CAST(N'2021-07-26T16:54:43.920' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (28, CAST(N'2021-07-26T16:54:58.103' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (29, CAST(N'2021-07-26T16:55:00.027' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (30, CAST(N'2021-07-26T16:55:14.177' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (31, CAST(N'2021-07-26T16:55:36.320' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (32, CAST(N'2021-07-26T17:25:02.940' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (33, CAST(N'2021-07-26T17:26:51.890' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (34, CAST(N'2021-07-26T17:28:42.660' AS DateTime), N'Column ''MachineName'' does not belong to table Table2.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Umesh_Work\xenpark-blank-template-UB-Latest\xenparkblanktemplate\Controllers\DashboardController.cs:line 491', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (35, CAST(N'2021-07-27T05:28:44.127' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (36, CAST(N'2021-07-27T05:28:45.003' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (37, CAST(N'2021-07-27T05:28:45.877' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (38, CAST(N'2021-07-27T05:29:12.437' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (39, CAST(N'2021-07-27T05:29:14.313' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (40, CAST(N'2021-07-27T05:29:27.503' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (41, CAST(N'2021-07-27T05:29:27.923' AS DateTime), N'Column ''OEE'' does not belong to table Table3.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 523', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (42, CAST(N'2021-07-27T05:48:57.127' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.
Warning: Null value is eliminated by an aggregate or other SET operation.
Warning: Null value is eliminated by an aggregate or other SET operation.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (43, CAST(N'2021-07-27T05:49:00.187' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.
Warning: Null value is eliminated by an aggregate or other SET operation.
Warning: Null value is eliminated by an aggregate or other SET operation.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (44, CAST(N'2021-07-27T08:35:20.133' AS DateTime), N'Error converting data type varchar to numeric.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (45, CAST(N'2021-07-27T08:35:24.387' AS DateTime), N'Error converting data type varchar to numeric.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (46, CAST(N'2021-07-27T08:36:36.247' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (47, CAST(N'2021-07-27T08:36:46.107' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (48, CAST(N'2021-07-27T08:36:47.123' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (49, CAST(N'2021-07-27T08:38:27.153' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (50, CAST(N'2021-07-27T08:38:29.150' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (51, CAST(N'2021-07-27T08:38:29.830' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (52, CAST(N'2021-07-27T08:38:30.277' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (53, CAST(N'2021-07-27T08:38:30.827' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (54, CAST(N'2021-07-27T08:38:31.243' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (55, CAST(N'2021-07-27T08:38:31.963' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (56, CAST(N'2021-07-27T08:38:32.417' AS DateTime), N'Conversion failed when converting the varchar value ''88:33:00'' to data type int.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 416', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (57, CAST(N'2021-07-27T15:01:51.657' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (58, CAST(N'2021-07-27T15:01:57.627' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (59, CAST(N'2021-07-27T15:01:59.680' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (60, CAST(N'2021-07-27T15:02:02.730' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (61, CAST(N'2021-07-27T15:38:09.617' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (62, CAST(N'2021-07-27T15:38:15.350' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (63, CAST(N'2021-07-27T15:38:20.357' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (64, CAST(N'2021-07-27T15:38:21.020' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (65, CAST(N'2021-07-27T15:39:18.017' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (66, CAST(N'2021-07-27T15:40:12.563' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (67, CAST(N'2021-07-27T15:40:12.590' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (68, CAST(N'2021-07-27T15:40:18.047' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (69, CAST(N'2021-07-27T15:40:24.973' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (70, CAST(N'2021-07-27T15:40:30.933' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (71, CAST(N'2021-07-27T15:40:58.300' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (72, CAST(N'2021-07-27T15:44:23.363' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (73, CAST(N'2021-07-27T15:46:14.510' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (74, CAST(N'2021-07-27T15:46:17.000' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (75, CAST(N'2021-07-27T15:46:17.973' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (76, CAST(N'2021-07-27T15:46:21.977' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (77, CAST(N'2021-07-27T15:47:00.690' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (78, CAST(N'2021-07-27T21:17:11.137' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 63', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (79, CAST(N'2021-07-27T15:48:18.677' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (80, CAST(N'2021-07-27T15:48:19.573' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (81, CAST(N'2021-07-27T15:48:23.237' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 43', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (82, CAST(N'2021-07-27T16:00:19.150' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (83, CAST(N'2021-07-27T16:00:22.887' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (84, CAST(N'2021-07-27T16:00:30.873' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (85, CAST(N'2021-07-27T16:00:38.157' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (86, CAST(N'2021-07-27T16:02:05.307' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (87, CAST(N'2021-07-27T16:02:06.860' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (88, CAST(N'2021-07-27T21:35:27.260' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (89, CAST(N'2021-07-27T21:35:29.660' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (90, CAST(N'2021-07-27T21:36:51.860' AS DateTime), N'Column name or number of supplied values does not match table definition.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (91, CAST(N'2021-08-01T23:52:56.573' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (92, CAST(N'2021-08-01T23:52:59.623' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (93, CAST(N'2021-08-01T23:53:00.623' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (94, CAST(N'2021-08-01T23:53:03.637' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (95, CAST(N'2021-08-01T23:53:44.233' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (96, CAST(N'2021-08-01T23:53:47.437' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (97, CAST(N'2021-08-01T23:53:48.403' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (98, CAST(N'2021-08-01T23:56:56.217' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (99, CAST(N'2021-08-01T23:56:57.233' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
GO
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (100, CAST(N'2021-08-01T23:56:58.270' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 404', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (101, CAST(N'2021-08-03T12:11:54.570' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (102, CAST(N'2021-08-03T12:13:23.443' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (103, CAST(N'2021-08-03T12:13:42.767' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (104, CAST(N'2021-08-03T12:15:15.120' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (105, CAST(N'2021-08-03T12:15:18.197' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (106, CAST(N'2021-08-03T12:18:03.990' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (107, CAST(N'2021-08-03T12:24:10.193' AS DateTime), N'Column ''DownTime'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 473', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (108, CAST(N'2021-08-03T12:24:10.263' AS DateTime), N'Column ''DownTime'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 473', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (109, CAST(N'2021-08-03T12:28:44.220' AS DateTime), N'Column ''DownTime'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 473', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (110, CAST(N'2021-08-03T12:28:47.220' AS DateTime), N'Column ''DownTime'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 473', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (111, CAST(N'2021-08-03T12:28:58.310' AS DateTime), N'Column ''DownTime'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 473', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (112, CAST(N'2021-08-03T12:30:17.307' AS DateTime), N'Divide by zero error encountered.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 417', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (113, CAST(N'2021-08-04T12:03:28.780' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToDecimal(IFormatProvider provider)
   at System.Convert.ToDecimal(Object value)
   at XenparkBlankTemplate.Controllers.DashboardController.GetOEEDefectDownTimeData(Int32 period, Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 526', N'System.Private.CoreLib', N'System.Decimal System.IConvertible.ToDecimal(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (114, CAST(N'2021-08-05T22:03:34.660' AS DateTime), N'A transport-level error has occurred when receiving results from the server. (provider: TCP Provider, error: 0 - The semaphore timeout period has expired.)', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParserStateObject.ThrowExceptionAndWarning(Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParserStateObject.ReadSniError(TdsParserStateObject stateObj, UInt32 error)
   at Microsoft.Data.SqlClient.TdsParserStateObject.ReadSniSyncOverAsync()
   at Microsoft.Data.SqlClient.TdsParserStateObject.TryReadNetworkPacket()
   at Microsoft.Data.SqlClient.TdsParserStateObject.TryPrepareBuffer()
   at Microsoft.Data.SqlClient.TdsParserStateObject.TryReadByte(Byte& value)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (115, CAST(N'2021-08-29T21:01:53.630' AS DateTime), N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: TCP Provider, error: 0 - A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.)', N'   at Microsoft.Data.ProviderBase.DbConnectionPool.CheckPoolBlockingPeriod(Exception e)
   at Microsoft.Data.ProviderBase.DbConnectionPool.CreateObject(DbConnection owningObject, DbConnectionOptions userOptions, DbConnectionInternal oldConnection)
   at Microsoft.Data.ProviderBase.DbConnectionPool.UserCreateRequest(DbConnection owningObject, DbConnectionOptions userOptions, DbConnectionInternal oldConnection)
   at Microsoft.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, UInt32 waitForMultipleObjectsTimeout, Boolean allowCreate, Boolean onlyOneCheckConnection, DbConnectionOptions userOptions, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at Microsoft.Data.SqlClient.SqlConnection.Open()
   at XenparkBlankTemplate.Controllers.DashboardController.GetBatchInformation(Int32 machineId) in D:\Xenpark\weavingplant\xenpark-weavingplant\XenparkBlankTemplate\Controllers\DashboardController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void CheckPoolBlockingPeriod(System.Exception)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (116, CAST(N'2022-03-10T10:17:30.473' AS DateTime), N'Procedure or function ''sprocAddEditBatch'' expects parameter ''@BatchNumber'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AddEditBatch(Batch batch) in D:\Xenpark\real-time-room-visibility\real-time-room-visibility\XenparkBlankTemplate\Controllers\BatchController.cs:line 178', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (117, CAST(N'2022-03-21T22:32:52.103' AS DateTime), N'Timeout expired.  The timeout period elapsed prior to obtaining a connection from the pool.  This may have occurred because all pooled connections were in use and max pool size was reached.', N'   at Microsoft.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.ProviderBase.DbConnectionClosed.TryOpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at Microsoft.Data.SqlClient.SqlConnection.Open()
   at XenparkBlankTemplate.Controllers.MasterController.GetRoomMaster() in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 180', N'Microsoft.Data.SqlClient', N'Boolean TryGetConnection(System.Data.Common.DbConnection, System.Threading.Tasks.TaskCompletionSource`1[Microsoft.Data.ProviderBase.DbConnectionInternal], Microsoft.Data.Common.DbConnectionOptions, Microsoft.Data.ProviderBase.DbConnectionInternal, Microsoft.Data.ProviderBase.DbConnectionInternal ByRef)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (118, CAST(N'2022-03-21T22:32:52.077' AS DateTime), N'Timeout expired.  The timeout period elapsed prior to obtaining a connection from the pool.  This may have occurred because all pooled connections were in use and max pool size was reached.', N'   at Microsoft.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.ProviderBase.DbConnectionClosed.TryOpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at Microsoft.Data.SqlClient.SqlConnection.Open()
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId, Boolean approveOnly) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 46', N'Microsoft.Data.SqlClient', N'Boolean TryGetConnection(System.Data.Common.DbConnection, System.Threading.Tasks.TaskCompletionSource`1[Microsoft.Data.ProviderBase.DbConnectionInternal], Microsoft.Data.Common.DbConnectionOptions, Microsoft.Data.ProviderBase.DbConnectionInternal, Microsoft.Data.ProviderBase.DbConnectionInternal ByRef)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (119, CAST(N'2022-03-21T22:32:52.093' AS DateTime), N'Timeout expired.  The timeout period elapsed prior to obtaining a connection from the pool.  This may have occurred because all pooled connections were in use and max pool size was reached.', N'   at Microsoft.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.ProviderBase.DbConnectionClosed.TryOpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at Microsoft.Data.SqlClient.SqlConnection.Open()
   at XenparkBlankTemplate.Controllers.RoleController.GetUserPermissions() in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoleController.cs:line 193', N'Microsoft.Data.SqlClient', N'Boolean TryGetConnection(System.Data.Common.DbConnection, System.Threading.Tasks.TaskCompletionSource`1[Microsoft.Data.ProviderBase.DbConnectionInternal], Microsoft.Data.Common.DbConnectionOptions, Microsoft.Data.ProviderBase.DbConnectionInternal, Microsoft.Data.ProviderBase.DbConnectionInternal ByRef)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (120, CAST(N'2022-03-21T22:32:52.077' AS DateTime), N'Timeout expired.  The timeout period elapsed prior to obtaining a connection from the pool.  This may have occurred because all pooled connections were in use and max pool size was reached.', N'   at Microsoft.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
   at Microsoft.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.ProviderBase.DbConnectionClosed.TryOpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
   at Microsoft.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
   at Microsoft.Data.SqlClient.SqlConnection.Open()
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 46', N'Microsoft.Data.SqlClient', N'Boolean TryGetConnection(System.Data.Common.DbConnection, System.Threading.Tasks.TaskCompletionSource`1[Microsoft.Data.ProviderBase.DbConnectionInternal], Microsoft.Data.Common.DbConnectionOptions, Microsoft.Data.ProviderBase.DbConnectionInternal, Microsoft.Data.ProviderBase.DbConnectionInternal ByRef)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (121, CAST(N'2022-03-22T11:11:48.320' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Column1'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 156', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (122, CAST(N'2022-03-22T11:12:27.413' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Column1'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (123, CAST(N'2022-03-22T11:14:28.263' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Column1'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (124, CAST(N'2022-03-22T11:54:43.890' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Code'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (125, CAST(N'2022-03-22T11:55:55.207' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Code'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (126, CAST(N'2022-03-22T11:57:25.763' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Description'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (127, CAST(N'2022-03-22T11:58:40.847' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Description'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 159', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (128, CAST(N'2022-03-22T12:37:48.247' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Column1'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 162', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (129, CAST(N'2022-03-22T13:56:57.623' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Description'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 162', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (130, CAST(N'2022-03-22T14:00:51.913' AS DateTime), N'Procedure or function ''sprocAddEditMaster'' expects parameter ''@Description'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.MasterController.AddEditMaster(String type, Master mast) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 162', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (131, CAST(N'2022-03-22T14:18:40.093' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId, Boolean approveOnly) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 69', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (132, CAST(N'2022-03-22T14:18:45.107' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId, Boolean approveOnly) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 69', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (133, CAST(N'2022-03-22T14:18:58.197' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at XenparkBlankTemplate.Controllers.MasterController.GetMasters(String type, Int32 parentId, Boolean approveOnly) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\MasterController.cs:line 69', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (134, CAST(N'2022-03-22T16:59:56.027' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (135, CAST(N'2022-03-22T16:59:56.233' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (136, CAST(N'2022-03-22T17:00:23.697' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (137, CAST(N'2022-03-22T17:02:17.593' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (138, CAST(N'2022-03-22T17:02:17.640' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (139, CAST(N'2022-03-22T17:22:51.787' AS DateTime), N'The DELETE statement conflicted with the REFERENCE constraint "FK_BatchLogger_Batch". The conflict occurred in database "weavingplantdb", table "dbo.BatchLogger", column ''BatchId''.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.CompleteBatch(String batchIds) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 232', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (140, CAST(N'2022-03-23T00:49:34.423' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (141, CAST(N'2022-03-23T00:52:37.543' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (142, CAST(N'2022-03-23T00:53:58.937' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (143, CAST(N'2022-03-23T00:55:34.837' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (144, CAST(N'2022-03-23T09:58:53.500' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (145, CAST(N'2022-03-23T09:58:56.043' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (146, CAST(N'2022-03-23T09:59:29.230' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (147, CAST(N'2022-03-23T17:04:18.907' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (148, CAST(N'2022-03-24T22:41:36.670' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (149, CAST(N'2022-03-24T23:03:15.680' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (150, CAST(N'2022-03-24T23:06:58.440' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (151, CAST(N'2022-03-24T23:07:33.590' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (152, CAST(N'2022-03-24T23:23:38.857' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (153, CAST(N'2022-03-24T23:24:07.263' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (154, CAST(N'2022-03-24T23:24:09.467' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (155, CAST(N'2022-03-24T23:29:02.233' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (156, CAST(N'2022-03-24T23:30:29.693' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (157, CAST(N'2022-03-24T23:44:32.393' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (158, CAST(N'2022-03-25T00:24:38.270' AS DateTime), N'Column ''UOM'' does not belong to table Table.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 67', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (159, CAST(N'2022-03-25T00:26:55.050' AS DateTime), N'Invalid column name ''BatchId''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (160, CAST(N'2022-03-25T00:27:46.977' AS DateTime), N'Invalid column name ''BatchId''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (161, CAST(N'2022-03-25T00:28:12.743' AS DateTime), N'Invalid column name ''BatchId''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (162, CAST(N'2022-03-25T00:28:40.877' AS DateTime), N'Invalid column name ''BatchId''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (163, CAST(N'2022-03-25T00:31:20.320' AS DateTime), N'Invalid column name ''BatchId''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (164, CAST(N'2022-03-25T00:31:30.340' AS DateTime), N'Column ''ToTimeStamp'' does not belong to table Table1.', N'   at System.Data.DataRow.GetDataColumn(String columnName)
   at System.Data.DataRow.get_Item(String columnName)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 95', N'System.Data.Common', N'System.Data.DataColumn GetDataColumn(System.String)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (165, CAST(N'2022-03-25T00:34:57.370' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 95', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (166, CAST(N'2022-03-25T00:36:54.483' AS DateTime), N'Object cannot be cast from DBNull to other types.', N'   at System.DBNull.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 95', N'System.Private.CoreLib', N'Int32 System.IConvertible.ToInt32(System.IFormatProvider)', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (167, CAST(N'2022-03-25T11:07:16.063' AS DateTime), N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_BatchLogger_Batch". The conflict occurred in database "weavingplantdb", table "dbo.Batch", column ''Id''.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AssignBatchToRoom(Int32 batchId, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 208', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (168, CAST(N'2022-03-25T11:40:47.173' AS DateTime), N'Procedure or function ''sprocAssignBatchToRoom'' expects parameter ''@UserId'', which was not supplied.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String methodName)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at XenparkBlankTemplate.Controllers.BatchController.AssignBatchToRoom(Int32 batchId, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 208', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (169, CAST(N'2022-03-25T12:44:42.677' AS DateTime), N'String or binary data would be truncated in table ''tempdb.dbo.#Rooms______________________________________________________________________________________________________________000000000129'', column ''ProductDesc''. Truncated value: ''Alben W. Barkley (1877–1956) was the 35th vice president of the United States, serving from 1949 to ''.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (170, CAST(N'2022-03-25T12:44:49.270' AS DateTime), N'String or binary data would be truncated in table ''tempdb.dbo.#Rooms______________________________________________________________________________________________________________00000000012B'', column ''ProductDesc''. Truncated value: ''Alben W. Barkley (1877–1956) was the 35th vice president of the United States, serving from 1949 to ''.
The statement has been terminated.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at Microsoft.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TrySetMetaData(_SqlMetaDataSet metaData, Boolean moreInfo)
   at Microsoft.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at Microsoft.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at Microsoft.Data.SqlClient.SqlDataReader.get_MetaData()
   at Microsoft.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption, Boolean shouldCacheForAlwaysEncrypted)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean isAsync, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at Microsoft.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry, String method)
   at Microsoft.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   at System.Data.Common.DbDataAdapter.Fill(DataSet dataSet)
   at XenparkBlankTemplate.Controllers.RoomController.GetRoomStatus(Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\RoomController.cs:line 56', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (171, CAST(N'2022-03-25T18:59:38.423' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (172, CAST(N'2022-03-25T18:59:40.673' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (173, CAST(N'2022-03-25T19:01:28.503' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (174, CAST(N'2022-03-25T19:03:11.317' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (175, CAST(N'2022-03-25T19:03:12.517' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (176, CAST(N'2022-03-25T19:26:40.290' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
INSERT [dbo].[ErrorLog] ([Id], [Date], [Message], [StackTrace], [Source], [TargetSite], [userId]) VALUES (177, CAST(N'2022-03-25T19:26:47.187' AS DateTime), N'Invalid object name ''BatchLogger''.', N'   at Microsoft.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
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
   at XenparkBlankTemplate.Controllers.BatchController.GetBatch(Boolean readyToAssign, Int32 roomId) in D:\xp\room-visibility-react-dotnet\XenparkBlankTemplate\Controllers\BatchController.cs:line 55', N'Core Microsoft SqlClient Data Provider', N'Void OnError(Microsoft.Data.SqlClient.SqlException, Boolean, System.Action`1[System.Action])', NULL)
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginInfo] ON 

INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (10, 10, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 0)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (24, 24, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (25, 25, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (26, 26, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (27, 27, N'viKsZ3HShHc3en5MX5CKaK/+9Zah4stpLwcSK3Jl82g=', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (28, 28, N'Ky7bC3RN4SGrO+6AMjHQNKWk+C4kBHiGsBupLf0CkiQ=', 0, NULL, 0, 1)
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (29, 29, N'HW6N+wdVhCsyY7yQ2FoKaA==', 0, NULL, 0, 1)
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
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (12, N'Role', N'item', N'/role', NULL, NULL, 0, NULL, 5)
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (13, N'Unit Of Measurement', N'item', N'/uom-master', NULL, NULL, 0, NULL, 5)
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
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (20, 13, 33)
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (21, 13, 34)
GO
SET IDENTITY_INSERT [dbo].[mylan_ProductMaster] ON 

INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (1, N'P001', N'Alben W. Barkley (1877–1956) was the 35th vice president of the United States, serving from 1949 to 1953. He was elected the U.S. representative from Kentucky''s first district in 1912 as a liberal Democrat, supporting President Woodrow Wilson''s New Freedom domestic agenda and foreign policy. In 1927 he entered the U.S. Senate, where he supported the New Deal, and was elected to succeed Joseph T. Robinson, Senate Majority Leader, upon Robinson''s death in 1937. He resigned as majority leader after President Franklin D. Roosevelt ignored his advice and vetoed the Revenue Act of 1943, but the veto was overridden and he was unanimously re-elected to the position. Barkley had a better working relationship with Harry S. Truman, who ascended to the presidency after Roosevelt''s death in 1945. At the 1948 Democratic National Convention, Barkley gave a keynote address that energized the delegates. Truman selected him as a running mate for the upcoming election, and the two scored an upset', 2, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (2, N'P002', N'Abacavir', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (3, N'P003', N'Baclofen', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (4, N'P004', N'Cephalexin', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (5, N'P005', N'Daunorubicin', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (6, N'P006', N'Enoxaparin', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (7, N'P007', N'G-CSF (Filgrastim)', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (8, N'P008', N'Hydrocortisone', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (9, N'P009', N'Benzodiazepines', 3, NULL, 1)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (10, N'1', N'1', 3, NULL, 0)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (11, N'qaqa', N'tetette', 3, NULL, 0)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (12, N'aa', N'aaaa', 2, NULL, 0)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (13, N'2', N'2', 1, NULL, 0)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (14, N'3', N'3', 1, NULL, 0)
INSERT [dbo].[mylan_ProductMaster] ([Id], [Code], [Description], [UOM], [Active], [Approved]) VALUES (15, N'hhhhh', N'  
            
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
   IF(@Type = ''product'')            
   BEGIN       
     IF NOT EXISTS(SELECT ''x'' FROM [mylan_ProductMaster] WHERE code = @Code)            
     BEGIN            
       INSERT INTO [mylan_ProductMaster] (Code, Description,Approved, UOM)            
       VALUES (@Code, @Description, 0, @ParentId)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = ''plant'')            
   BEGIN            
     SELECT TOP 1 @MaxId = Id From Area Order By Id desc                 
     IF NOT EXISTS(SELECT ''x'' FROM [Plant] WHERE PlantName = @Code AND Location = @Description)            
     BEGIN            
       INSERT INTO [Plant] (PlantName, Location, Approved)            
       VALUES (@Code, @Description, 0)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type = ''block'')            
   BEGIN  
     SELECT TOP 1 @MaxId = Id From Area Order By Id desc   
     IF NOT EXISTS(SELECT ''x'' FROM [Block] WHERE Description = @Description AND PlantId = @ParentId)            
     BEGIN            
       INSERT INTO [Block] (Code, Description,ReferenceNumber,FormNumber,VersionNumber, PlantId, Approved)            
       VALUES (CONVERT(VARCHAR,@MaxId+1), @Description,@Column1,@Column2,@Column3, @ParentId, 0)            
       SET @ReturnValue = 101            
     END            
   END            
   IF(@Type ', 2, NULL, 0)
SET IDENTITY_INSERT [dbo].[mylan_ProductMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[mylan_UnitOfMeasure] ON 

INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (1, N'No', N'Number', 1)
INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (2, N'u1', N'u11', 1)
INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (3, N'3', N'Ltr', 0)
INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (4, N'4', N'1', 0)
INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (5, N'5', N'2', 0)
INSERT [dbo].[mylan_UnitOfMeasure] ([Id], [Code], [Description], [Approved]) VALUES (6, N'6', N'3', 0)
SET IDENTITY_INSERT [dbo].[mylan_UnitOfMeasure] OFF
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
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (32, N'Create and Assign Batch', N'Dashboard')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (33, N'Add/Edit Unit Of Measure', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (34, N'View Unit Of Measure', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (35, N'Delete Unit Of Measure', N'Masters')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (36, N'No Activity', N'Workflow Status')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (37, N'Production', N'Workflow Status')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (38, N'Cleaning', N'Workflow Status')
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (39, N'Maintenance', N'Workflow Status')
GO
SET IDENTITY_INSERT [dbo].[Plant] ON 

INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (1, N'Mylan', N'Pithampur', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (2, N'Mylan', N'Nasik', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (3, N'Mylan', N'Aurangabad', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (4, N'VX', N'TEST', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (5, N'P1', N'qqq', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (6, N'7', N'1', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (7, N'7', N'2', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (8, N'1', N'1', 1)
INSERT [dbo].[Plant] ([Id], [PlantName], [Location], [Approved]) VALUES (9, N'2', N'2', 1)
SET IDENTITY_INSERT [dbo].[Plant] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (1, N'Manager', N'Manager', 0, 0)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (2, N'Supervisor', N'Supervisor', 0, 1)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (3, N'Operator', N'Operator', 0, 1)
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (4, N'System Admin', N'System Admin', 1, 0)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[RolePermission] ON 

INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (46, 3, 7)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (47, 4, 1)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (48, 4, 2)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (49, 4, 3)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (50, 4, 4)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (51, 4, 5)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (52, 4, 6)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (53, 4, 7)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (54, 4, 8)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (55, 4, 9)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (56, 4, 10)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (57, 4, 11)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (58, 4, 12)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (59, 4, 13)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (60, 4, 14)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (61, 4, 15)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (62, 4, 16)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (63, 4, 17)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (64, 4, 18)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (65, 4, 19)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (66, 4, 20)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (67, 4, 21)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (68, 4, 22)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (69, 4, 23)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (70, 4, 24)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (71, 4, 25)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (72, 4, 26)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (73, 4, 27)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (74, 4, 28)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (75, 4, 29)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (76, 4, 30)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (77, 4, 31)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (78, 4, 32)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (313, 2, 11)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (314, 2, 12)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (315, 2, 14)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (316, 2, 15)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (317, 2, 17)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (318, 2, 18)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (319, 2, 20)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (320, 2, 21)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (321, 2, 26)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (322, 2, 27)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (323, 2, 29)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (324, 2, 30)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (325, 2, 7)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (326, 2, 8)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (327, 2, 9)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (363, 4, 33)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (364, 4, 34)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (365, 4, 35)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (438, 1, 1)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (439, 1, 10)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (440, 1, 11)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (441, 1, 12)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (442, 1, 13)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (443, 1, 14)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (444, 1, 15)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (445, 1, 16)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (446, 1, 17)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (447, 1, 18)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (448, 1, 19)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (449, 1, 2)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (450, 1, 20)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (451, 1, 21)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (452, 1, 22)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (453, 1, 23)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (454, 1, 24)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (455, 1, 25)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (456, 1, 26)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (457, 1, 27)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (458, 1, 28)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (459, 1, 29)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (460, 1, 3)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (461, 1, 30)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (462, 1, 31)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (463, 1, 33)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (464, 1, 34)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (465, 1, 35)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (466, 1, 36)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (467, 1, 37)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (468, 1, 38)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (469, 1, 39)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (470, 1, 4)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (471, 1, 5)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (472, 1, 6)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (473, 1, 7)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (474, 1, 8)
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (475, 1, 9)
SET IDENTITY_INSERT [dbo].[RolePermission] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (1, N'1001', N'FBD Drying', 1, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (2, N'1002', N'Granulation Room', 2, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (3, N'1003', N'Drying Room', 1, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (4, N'1004', N'Compaction Room', 1, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (5, N'1005', N'Coating Room', 2, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (6, N'1006', N'Granulation Big New Room', 2, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (7, N'11', N'112', 3, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (8, N'12', N'112', 3, NULL, 1, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (9, N'1', N'1', 1, NULL, 0, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (10, N'2', N'2', 1, NULL, 0, NULL)
INSERT [dbo].[Room] ([Id], [Code], [Description], [AreaId], [Status], [Approved], [DeviceIPAddress]) VALUES (11, N'1', N'1', 2, NULL, 0, NULL)
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomLog] ON 

INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp], [BatchId], [BatchSize], [UOM], [UserId]) VALUES (232, 1, 1, CAST(N'2022-03-25T12:17:15.187' AS DateTime), 18, 1000, 3, 25)
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp], [BatchId], [BatchSize], [UOM], [UserId]) VALUES (233, 1, 1, CAST(N'2022-03-25T12:17:36.523' AS DateTime), 19, 5000, 3, 25)
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp], [BatchId], [BatchSize], [UOM], [UserId]) VALUES (234, 1, 1, CAST(N'2022-03-25T12:17:46.630' AS DateTime), 18, 1000, 3, 25)
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp], [BatchId], [BatchSize], [UOM], [UserId]) VALUES (235, 1, 1, CAST(N'2022-03-25T12:44:42.483' AS DateTime), 20, 2000, 2, 25)
INSERT [dbo].[RoomLog] ([Id], [RoomId], [StatusId], [TimeStamp], [BatchId], [BatchSize], [UOM], [UserId]) VALUES (236, 1, 1, CAST(N'2022-03-25T12:48:39.160' AS DateTime), 19, 5000, 3, 25)
SET IDENTITY_INSERT [dbo].[RoomLog] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] ON 

INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (1, N'No Activity', 1, 0, 0)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (2, N'Production', 2, 0, 1)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (3, N'Cleaning', 3, 0, 0)
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (4, N'Maintenance', 4, 1, 0)
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] OFF
GO
SET IDENTITY_INSERT [dbo].[UnitOfMesurementMaster] ON 

INSERT [dbo].[UnitOfMesurementMaster] ([Id], [Code], [Description], [DelStatus], [AddedBy], [AddedOn], [LastUpBy], [LastUpOn]) VALUES (1, N'Nos', N'Numbers', 0, 1, CAST(N'2021-10-20T00:00:00.000' AS DateTime), 1, CAST(N'2021-10-20T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[UnitOfMesurementMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (10, N'Sysadmin', N'Admin', N'choudharydeepak2007@gmail.com', N'a', 4, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (24, N'James', N'Hernandez', N'supervisor@gmail.com', N'rks', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (25, N'Hugh', N'Jackman', N'manager@gmail.com', N'manager', 1, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (26, N'Christian ', N'Bale', N'operator@gmail.com', N'operator', 3, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (27, N'Isabella', N'Pine', N'mark@gmail.com', N'mark', 1, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (28, N'Harold', N'Sepulchre', N'harold@gmail.com', N'harold', 2, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (29, N'Umesh', N'Bakre', N'ubakre@gmail.com', N'umesh', 3, 0, 0)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (30, N'Ryan ', N'Gosling', N'support.IT@ics-india.co.in', N'Ankit Chouhan', 4, 0, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[LoginInfo] ADD  CONSTRAINT [DF_LoginInfo_IncorrectAttempt]  DEFAULT ((0)) FOR [IncorrectAttempt]
GO
ALTER TABLE [dbo].[LoginInfo] ADD  CONSTRAINT [DF_LoginInfo_Blocked]  DEFAULT ((0)) FOR [Blocked]
GO
ALTER TABLE [dbo].[LoginInfo] ADD  DEFAULT ((0)) FOR [ForceChangePassword]
GO
ALTER TABLE [dbo].[mylan_UnitOfMeasure] ADD  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Batch_mylan_ProductMaster] FOREIGN KEY([ProductId])
REFERENCES [dbo].[mylan_ProductMaster] ([Id])
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Batch_mylan_ProductMaster]
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
ALTER TABLE [dbo].[mylan_ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_mylan_ProductMaster_mylan_UnitOfMeasure] FOREIGN KEY([UOM])
REFERENCES [dbo].[mylan_UnitOfMeasure] ([Id])
GO
ALTER TABLE [dbo].[mylan_ProductMaster] CHECK CONSTRAINT [FK_mylan_ProductMaster_mylan_UnitOfMeasure]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Area] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([Id])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Area]
GO
ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_Batch_RoomLog_BatchId] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batch] ([Id])
GO
ALTER TABLE [dbo].[RoomLog] CHECK CONSTRAINT [FK_Batch_RoomLog_BatchId]
GO
ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_mylan_UOM_RoomLog_UOM] FOREIGN KEY([UOM])
REFERENCES [dbo].[mylan_UnitOfMeasure] ([Id])
GO
ALTER TABLE [dbo].[RoomLog] CHECK CONSTRAINT [FK_mylan_UOM_RoomLog_UOM]
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
ALTER TABLE [dbo].[RoomLog]  WITH CHECK ADD  CONSTRAINT [FK_User_RoomLog_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[RoomLog] CHECK CONSTRAINT [FK_User_RoomLog_UserId]
GO
ALTER TABLE [dbo].[UserRoom]  WITH CHECK ADD  CONSTRAINT [FK_UserRoom_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([Id])
GO
ALTER TABLE [dbo].[UserRoom] CHECK CONSTRAINT [FK_UserRoom_Room]
GO
ALTER TABLE [dbo].[UserRoom]  WITH CHECK ADD  CONSTRAINT [FK_UserRoom_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserRoom] CHECK CONSTRAINT [FK_UserRoom_User]
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditBatch]    Script Date: 25-03-2022 22:26:19 ******/
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
      
END  
  
  
GO
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditRolePermission]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditUser]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocApproveMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAssignBatchToRoom]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 25-03-2022 22:26:19 ******/
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
DECLARE @RoomCurrentStatusId  int;

select TOP 1 @RoomCurrentStatusId = StatusId  FROM RoomLog WHERE RoomId = @RoomId ORDER BY Id DESC;
-- Create a record in RoomLog
INSERT INTO dbo.RoomLog(RoomId, StatusId, [TimeStamp])
SELECT  @RoomId, @StatusId, GETDATE()
WHERE NOT EXISTS (SELECT 1 FROM BatchLogger WHERE BatchId = @BatchId  AND RoomId =@RoomId AND ISCompleted = 1)


--DECLARE @StatusOrder INT;
--SELECT @StatusOrder = [Order] FROM StatusWorkFlow WHERE Id = @StatusId

--UPDATE BatchLogger SET ISCompleted = 1
--WHERE BatchId = @BatchId  AND RoomId =@RoomId AND @StatusOrder = 1

Declare @IsProductProcessing BIT;
Select @IsProductProcessing = ProductProcessing FROM StatusWorkFlow WHERE Id = @StatusId;

UPDATE BatchLogger SET ISCompleted = 1
WHERE BatchId = @BatchId  AND RoomId =@RoomId 
AND NOT EXISTS (SELECT 1 FROM StatusWorkFlow 
				WHERE Id = @RoomCurrentStatusId 
				AND ISNULL(ProductProcessing, 0) = 0 )
				

END
GO
/****** Object:  StoredProcedure [dbo].[sprocDeleteMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetAvailableBatches]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetBatch]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMasterHierarchy]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMenus]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetPermissions]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetPlantMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoles]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomByIPAddress]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomMaster]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 25-03-2022 22:26:19 ******/
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
  ,BatchSize  = B.BatchSize  
  ,UOM = uom.Description  
FROM #Rooms temp
INNER JOIN RoomLog RL ON temp.RoomId = RL.RoomId 
INNER JOIN (      
   SELECT max(Id) as Id FROM RoomLog RLSub
   Group By RoomId      
   ) RLTop ON RLTop.Id = RL.Id
INNER JOIN dbo.Batch B On B.Id = RL.BatchId      
INNER JOIN dbo.mylan_ProductMaster P ON P.Id = B.ProductId  
INNER JOIN mylan_UnitOfMeasure uom ON uom.Id = P.UOM  
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
   
     
SELECT * FROM #Rooms R ORDER BY RoomId asc, [TimeStamp] desc    
SELECT * FROM #RoomLog ORDER BY RoomId, RoomStatusOrder      
     
DROP Table #Rooms                    
DROP Table #RoomLog                
               
END      
GO
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatusWorkFlow]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUser]    Script Date: 25-03-2022 22:26:19 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUserPermissions]    Script Date: 25-03-2022 22:26:19 ******/
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
USE [master]
GO
ALTER DATABASE [weavingplantdb] SET  READ_WRITE 
GO
