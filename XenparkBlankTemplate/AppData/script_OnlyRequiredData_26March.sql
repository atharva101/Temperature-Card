
USE [MyLanRoomStatusDB]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Batch]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Block]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[LoginInfo]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[MenuPermission]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[mylan_ProductMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[mylan_UnitOfMeasure]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Permission]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Plant]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[RolePermission]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[RoomLog]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[StatusWorkFlow]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[UnitOfMesurementMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  Table [dbo].[UserRoom]    Script Date: 26-03-2022 01:23:57 ******/
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
SET IDENTITY_INSERT [dbo].[LoginInfo] ON 
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (10, 10, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 0)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (24, 24, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (25, 25, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (26, 26, N'/NNfWRStbZsUyc88S5tjhA==', 0, NULL, 0, 1)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (27, 27, N'viKsZ3HShHc3en5MX5CKaK/+9Zah4stpLwcSK3Jl82g=', 0, NULL, 0, 1)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (28, 28, N'Ky7bC3RN4SGrO+6AMjHQNKWk+C4kBHiGsBupLf0CkiQ=', 0, NULL, 0, 1)
GO
INSERT [dbo].[LoginInfo] ([Id], [UserId], [Password], [IncorrectAttempt], [LastLogInTime], [Blocked], [ForceChangePassword]) VALUES (29, 29, N'HW6N+wdVhCsyY7yQ2FoKaA==', 0, NULL, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[LoginInfo] OFF
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (1, N' ', N'group', NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (2, N'Dashboard', N'item', N'/room-list', N'feather icon-monitor', NULL, 0, NULL, 1)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (3, N'Manage Batch', N'item', N'/batch', N'feather icon-layout', NULL, 0, NULL, 1)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (4, N'Manage Users', N'item', N'/user', N'feather icon-user', NULL, 0, NULL, 1)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (5, N'System Setup', N'collapse', NULL, N'feather icon-settings', NULL, 0, NULL, 1)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (6, N'Plant', N'item', N'/plant-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (7, N'Block', N'item', N'/block-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (8, N'Area', N'item', N'/area-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (9, N'Room', N'item', N'/room-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (10, N'Product', N'item', N'/product-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (12, N'Role', N'item', N'/role', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[Menu] ([Id], [Title], [Type], [URL], [Icon], [Target], [Breadcrumbs], [Classes], [ParentId]) VALUES (13, N'Unit Of Measurement', N'item', N'/uom-master', NULL, NULL, 0, NULL, 5)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (1, 4, 1)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (2, 4, 2)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (3, 12, 4)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (4, 12, 5)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (5, 2, 7)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (6, 6, 8)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (7, 6, 9)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (8, 7, 11)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (9, 7, 12)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (10, 8, 14)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (11, 8, 15)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (12, 9, 17)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (13, 9, 18)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (14, 10, 20)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (15, 10, 21)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (16, 11, 23)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (17, 11, 24)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (18, 3, 26)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (19, 3, 27)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (20, 13, 33)
GO
INSERT [dbo].[MenuPermission] ([Id], [MenuId], [PermissionId]) VALUES (21, 13, 34)
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (1, N'Add/Edit Users', N'Manage Users')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (2, N'View Users', N'Manage Users')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (3, N'Delete Users', N'Manage Users')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (4, N'Add/Edit Roles and Permissions', N'Manage Roles')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (5, N'View Roles and Permissions', N'Manage Roles')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (6, N'Delete Roles and Permissions', N'Manage Roles')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (7, N'View Dashboard', N'Dashboard')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (8, N'Add/Edit Plant', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (9, N'View Plant', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (10, N'Delete Plant', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (11, N'Add/Edit Block', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (12, N'View Block', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (13, N'Delete Block', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (14, N'Add/Edit Area', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (15, N'View Area', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (16, N'Delete Area', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (17, N'Add/Edit Room', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (18, N'View Room', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (19, N'Delete Room', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (20, N'Add/Edit Product', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (21, N'View Product', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (22, N'Delete Product', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (23, N'Add/Edit Workflow', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (24, N'View Workflow', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (25, N'Delete Workflow', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (26, N'Add/Edit Batch', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (27, N'View Batch', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (28, N'Delete Batch', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (29, N'Assign Batch to Room', N'Dashboard')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (30, N'Change Batch Status', N'Dashboard')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (31, N'Approve Masters', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (32, N'Create and Assign Batch', N'Dashboard')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (33, N'Add/Edit Unit Of Measure', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (34, N'View Unit Of Measure', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (35, N'Delete Unit Of Measure', N'Masters')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (36, N'No Activity', N'Workflow Status')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (37, N'Production', N'Workflow Status')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (38, N'Cleaning', N'Workflow Status')
GO
INSERT [dbo].[Permission] ([Id], [PermissionName], [GroupName]) VALUES (39, N'Maintenance', N'Workflow Status')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (1, N'Manager', N'Manager', 0, 0)
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (2, N'Supervisor', N'Supervisor', 0, 1)
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (3, N'Operator', N'Operator', 0, 1)
GO
INSERT [dbo].[Role] ([Id], [Name], [Description], [SysRole], [Approved]) VALUES (4, N'System Admin', N'System Admin', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[RolePermission] ON 
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (46, 3, 7)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (47, 4, 1)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (48, 4, 2)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (49, 4, 3)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (50, 4, 4)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (51, 4, 5)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (52, 4, 6)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (53, 4, 7)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (54, 4, 8)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (55, 4, 9)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (56, 4, 10)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (57, 4, 11)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (58, 4, 12)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (59, 4, 13)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (60, 4, 14)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (61, 4, 15)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (62, 4, 16)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (63, 4, 17)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (64, 4, 18)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (65, 4, 19)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (66, 4, 20)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (67, 4, 21)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (68, 4, 22)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (69, 4, 23)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (70, 4, 24)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (71, 4, 25)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (72, 4, 26)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (73, 4, 27)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (74, 4, 28)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (75, 4, 29)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (76, 4, 30)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (77, 4, 31)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (78, 4, 32)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (313, 2, 11)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (314, 2, 12)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (315, 2, 14)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (316, 2, 15)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (317, 2, 17)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (318, 2, 18)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (319, 2, 20)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (320, 2, 21)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (321, 2, 26)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (322, 2, 27)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (323, 2, 29)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (324, 2, 30)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (325, 2, 7)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (326, 2, 8)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (327, 2, 9)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (363, 4, 33)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (364, 4, 34)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (365, 4, 35)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (438, 1, 1)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (439, 1, 10)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (440, 1, 11)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (441, 1, 12)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (442, 1, 13)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (443, 1, 14)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (444, 1, 15)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (445, 1, 16)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (446, 1, 17)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (447, 1, 18)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (448, 1, 19)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (449, 1, 2)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (450, 1, 20)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (451, 1, 21)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (452, 1, 22)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (453, 1, 23)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (454, 1, 24)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (455, 1, 25)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (456, 1, 26)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (457, 1, 27)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (458, 1, 28)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (459, 1, 29)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (460, 1, 3)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (461, 1, 30)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (462, 1, 31)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (463, 1, 33)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (464, 1, 34)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (465, 1, 35)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (466, 1, 36)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (467, 1, 37)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (468, 1, 38)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (469, 1, 39)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (470, 1, 4)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (471, 1, 5)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (472, 1, 6)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (473, 1, 7)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (474, 1, 8)
GO
INSERT [dbo].[RolePermission] ([Id], [RoleId], [PermissionId]) VALUES (475, 1, 9)
GO
SET IDENTITY_INSERT [dbo].[RolePermission] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] ON 
GO
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (1, N'No Activity', 1, 0, 0)
GO
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (2, N'Production', 2, 0, 1)
GO
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (3, N'Cleaning', 3, 0, 0)
GO
INSERT [dbo].[StatusWorkFlow] ([Id], [Status], [Order], [IsFinal], [ProductProcessing]) VALUES (4, N'Maintenance', 4, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[StatusWorkFlow] OFF
GO
SET IDENTITY_INSERT [dbo].[UnitOfMesurementMaster] ON 
GO
INSERT [dbo].[UnitOfMesurementMaster] ([Id], [Code], [Description], [DelStatus], [AddedBy], [AddedOn], [LastUpBy], [LastUpOn]) VALUES (1, N'Nos', N'Numbers', 0, 1, CAST(N'2021-10-20T00:00:00.000' AS DateTime), 1, CAST(N'2021-10-20T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[UnitOfMesurementMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (10, N'Sysadmin', N'Admin', N'choudharydeepak2007@gmail.com', N'a', 4, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (24, N'James', N'Hernandez', N'supervisor@gmail.com', N'rks', 2, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (25, N'Hugh', N'Jackman', N'manager@gmail.com', N'manager', 1, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (26, N'Christian ', N'Bale', N'operator@gmail.com', N'operator', 3, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (27, N'Isabella', N'Pine', N'mark@gmail.com', N'mark', 1, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (28, N'Harold', N'Sepulchre', N'harold@gmail.com', N'harold', 2, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (29, N'Umesh', N'Bakre', N'ubakre@gmail.com', N'umesh', 3, 0, 0)
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [UserName], [RoleId], [IsDisabled], [IsDeleted]) VALUES (30, N'Ryan ', N'Gosling', N'support.IT@ics-india.co.in', N'Ankit Chouhan', 4, 0, 0)
GO
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditBatch]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditRolePermission]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAddEditUser]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocApproveMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocAssignBatchToRoom]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocChangeRoomStatus]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocDeleteMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocEditBatchSize]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetAvailableBatches]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetBatch]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMasterHierarchy]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetMenus]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetPermissions]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetPlantMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoles]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomByIPAddress]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomMaster]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatus]    Script Date: 26-03-2022 01:23:57 ******/
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
INNER JOIN mylan_UnitOfMeasure uom ON uom.Id = RL.UOM    
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
/****** Object:  StoredProcedure [dbo].[sprocGetRoomStatusWorkFlow]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUser]    Script Date: 26-03-2022 01:23:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sprocGetUserPermissions]    Script Date: 26-03-2022 01:23:57 ******/
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