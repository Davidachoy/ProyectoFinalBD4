USE [master]
GO
/****** Object:  Database [tareaBD3]    Script Date: 07/06/2022 12:36:44 p. m. ******/
CREATE DATABASE [tareaBD3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tareaBD3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\tareaBD3.mdf' , SIZE = 466944KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tareaBD3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\tareaBD3_log.ldf' , SIZE = 4661248KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [tareaBD3] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tareaBD3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tareaBD3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tareaBD3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tareaBD3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tareaBD3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tareaBD3] SET ARITHABORT OFF 
GO
ALTER DATABASE [tareaBD3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tareaBD3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tareaBD3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tareaBD3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tareaBD3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tareaBD3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tareaBD3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tareaBD3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tareaBD3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tareaBD3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tareaBD3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tareaBD3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tareaBD3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tareaBD3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tareaBD3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tareaBD3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tareaBD3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tareaBD3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [tareaBD3] SET  MULTI_USER 
GO
ALTER DATABASE [tareaBD3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tareaBD3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tareaBD3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tareaBD3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tareaBD3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [tareaBD3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [tareaBD3] SET QUERY_STORE = OFF
GO
USE [tareaBD3]
GO
/****** Object:  UserDefinedTableType [dbo].[CustomerType]    Script Date: 07/06/2022 12:36:44 p. m. ******/
CREATE TYPE [dbo].[CustomerType] AS TABLE(
	[Id] [int] NULL,
	[Name] [varchar](100) NULL,
	[Country] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EmpleadosInsertar]    Script Date: 07/06/2022 12:36:44 p. m. ******/
CREATE TYPE [dbo].[EmpleadosInsertar] AS TABLE(
	[Sec] [int] IDENTITY(1,1) NOT NULL,
	[FechaNacimiento] [date] NULL,
	[Nombre] [varchar](64) NULL,
	[IdTipoDocumento] [int] NULL,
	[ValorDocumento] [int] NULL,
	[IdDepartamento] [int] NULL,
	[IdPuesto] [int] NULL,
	[Usuario] [varchar](64) NULL,
	[Password] [varchar](64) NULL
)
GO
/****** Object:  Table [dbo].[Debito]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Debito](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Monto] [money] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_Debito] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionesXEmpleadoXMes]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionesXEmpleadoXMes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPlanillaMesXEmp] [int] NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
	[TotalDeduccion] [money] NOT NULL,
 CONSTRAINT [PK_DeduccionesXEmpleadoXMes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionPorcentualObligatoria]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionPorcentualObligatoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Porcentaje] [float] NOT NULL,
 CONSTRAINT [PK_DeduccionPorcentualObligatoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeduccionXEmpleado]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeduccionXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
	[IdFijaNoObligatoria] [int] NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_DeduccionXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK__Departam__3213E83F10CA410E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[IdTipoIdentificacion] [int] NOT NULL,
	[ValorDocumentoIdentificacion] [int] NOT NULL,
	[IdDepartamento] [int] NOT NULL,
	[IdPuesto] [int] NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK__Empleado__B541194008C09EF0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feriado]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feriado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Feriado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FijaNoObligatoria]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FijaNoObligatoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Monto] [float] NOT NULL,
 CONSTRAINT [PK_FijaNoObligatoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jornada](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdSemanaPlanilla] [int] NOT NULL,
	[IdTipoJornada] [int] NOT NULL,
 CONSTRAINT [PK_Jornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarcarAsistencia]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcarAsistencia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdJornada] [int] NOT NULL,
	[MarcarInicio] [smalldatetime] NOT NULL,
	[MarcarFin] [smalldatetime] NOT NULL,
	[horaOrdinaria] [int] NOT NULL,
	[horaExtra] [int] NOT NULL,
	[horaDoble] [int] NOT NULL,
 CONSTRAINT [PK_MarcarAsistencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MesPlanilla]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MesPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
 CONSTRAINT [PK_MesPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovDeduccion]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovDeduccion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDeduccionXEmp] [int] NOT NULL,
 CONSTRAINT [PK_MovDeduccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovHoras]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovHoras](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[horas] [int] NOT NULL,
	[IdMarcarAsistencia] [int] NOT NULL,
 CONSTRAINT [PK_MovHoras] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovPlanilla]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoMov] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL,
	[horas] [int] NOT NULL,
 CONSTRAINT [PK_MovPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovVacacional]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovVacacional](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Saldo] [money] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdDebito] [int] NOT NULL,
	[IdTipoMovVac] [int] NOT NULL,
 CONSTRAINT [PK_MovVacacional] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanillaMesXEmpleado]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaMesXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMesPlanilla] [int] NOT NULL,
	[SalarioNeto] [money] NOT NULL,
	[SalarioTotal] [money] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_PlanillaMesXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanillaSemXEmpleado]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanillaSemXEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SalarioNeto] [money] NOT NULL,
	[IdPlanillaSem] [int] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[TotalSalarioBruto] [money] NOT NULL,
 CONSTRAINT [PK_PlanillaSemXEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puesto]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puesto](
	[id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[SalarioXHora] [money] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK__Puesto__75E3EFCE8CC6D057] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SemanaPlanilla]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SemanaPlanilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idMesPlanilla] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
 CONSTRAINT [PK_SemanaPlanilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDeduccion]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDeduccion](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[EsObligatorio] [varchar](64) NOT NULL,
	[EsPorcentual] [varchar](64) NOT NULL,
	[IdDeduccionObligatoria] [int] NOT NULL,
 CONSTRAINT [PK_TipoDeduccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocuIdentidad]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDocuIdentidad](
	[id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK__TipoDocu__3213E83FA46146E3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoJornada]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoJornada](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[HoraInicio] [time](0) NOT NULL,
	[HoraFin] [time](0) NOT NULL,
 CONSTRAINT [PK_TipoJornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovDeduccion]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovDeduccion](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
	[idTipoDeduccion] [int] NOT NULL,
 CONSTRAINT [PK_TipoMovDeduccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovPlantilla]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovPlantilla](
	[Id] [int] NOT NULL,
	[IdTipoMovDeduccion] [int] NULL,
	[Nombre] [varchar](64) NOT NULL,
 CONSTRAINT [PK_TipoMovPlantilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovVac]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovVac](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
 CONSTRAINT [PK_TipoMovVac] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Password] [varchar](64) NOT NULL,
	[EsAdministrador] [bit] NOT NULL,
 CONSTRAINT [PK__Usuario__75E3EFCEC29ECB32] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] ADD  CONSTRAINT [DF_DeduccionXEmpleado_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Empleado] ADD  CONSTRAINT [DF__Empleado__Activo__403A8C7D]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Puesto] ADD  CONSTRAINT [DF__Puesto__Activo__38996AB5]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_EsAdministrador]  DEFAULT ((0)) FOR [EsAdministrador]
GO
ALTER TABLE [dbo].[Debito]  WITH CHECK ADD  CONSTRAINT [FK_Debito_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[Debito] CHECK CONSTRAINT [FK_Debito_Empleado]
GO
ALTER TABLE [dbo].[DeduccionesXEmpleadoXMes]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionesXEmpleadoXMes_PlanillaMesXEmpleado] FOREIGN KEY([IdPlanillaMesXEmp])
REFERENCES [dbo].[PlanillaMesXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionesXEmpleadoXMes] CHECK CONSTRAINT [FK_DeduccionesXEmpleadoXMes_PlanillaMesXEmpleado]
GO
ALTER TABLE [dbo].[DeduccionesXEmpleadoXMes]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionesXEmpleadoXMes_TipoDeduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[DeduccionesXEmpleadoXMes] CHECK CONSTRAINT [FK_DeduccionesXEmpleadoXMes_TipoDeduccion]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXEmpleado_Empleado1] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] CHECK CONSTRAINT [FK_DeduccionXEmpleado_Empleado1]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXEmpleado_FijaNoObligatoria] FOREIGN KEY([IdFijaNoObligatoria])
REFERENCES [dbo].[FijaNoObligatoria] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] CHECK CONSTRAINT [FK_DeduccionXEmpleado_FijaNoObligatoria]
GO
ALTER TABLE [dbo].[DeduccionXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DeduccionXEmpleado_TipoDeduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[DeduccionXEmpleado] CHECK CONSTRAINT [FK_DeduccionXEmpleado_TipoDeduccion]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK__Empleado__IdDepa__3E52440B] FOREIGN KEY([IdDepartamento])
REFERENCES [dbo].[Departamento] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK__Empleado__IdDepa__3E52440B]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK__Empleado__IdTipo__3D5E1FD2] FOREIGN KEY([IdTipoIdentificacion])
REFERENCES [dbo].[TipoDocuIdentidad] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK__Empleado__IdTipo__3D5E1FD2]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Puesto1] FOREIGN KEY([IdPuesto])
REFERENCES [dbo].[Puesto] ([id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_Empleado_Puesto1]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_Empleado]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_SemanaPlanilla] FOREIGN KEY([IdSemanaPlanilla])
REFERENCES [dbo].[SemanaPlanilla] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_SemanaPlanilla]
GO
ALTER TABLE [dbo].[Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Jornada_TipoJornada] FOREIGN KEY([IdTipoJornada])
REFERENCES [dbo].[TipoJornada] ([Id])
GO
ALTER TABLE [dbo].[Jornada] CHECK CONSTRAINT [FK_Jornada_TipoJornada]
GO
ALTER TABLE [dbo].[MarcarAsistencia]  WITH CHECK ADD  CONSTRAINT [FK_MarcarAsistencia_Jornada] FOREIGN KEY([IdJornada])
REFERENCES [dbo].[Jornada] ([Id])
GO
ALTER TABLE [dbo].[MarcarAsistencia] CHECK CONSTRAINT [FK_MarcarAsistencia_Jornada]
GO
ALTER TABLE [dbo].[MovDeduccion]  WITH CHECK ADD  CONSTRAINT [FK_MovDeduccion_DeduccionXEmpleado] FOREIGN KEY([IdDeduccionXEmp])
REFERENCES [dbo].[DeduccionXEmpleado] ([Id])
GO
ALTER TABLE [dbo].[MovDeduccion] CHECK CONSTRAINT [FK_MovDeduccion_DeduccionXEmpleado]
GO
ALTER TABLE [dbo].[MovPlanilla]  WITH CHECK ADD  CONSTRAINT [FK_MovPlanilla_TipoMovPlantilla] FOREIGN KEY([IdTipoMov])
REFERENCES [dbo].[TipoMovPlantilla] ([Id])
GO
ALTER TABLE [dbo].[MovPlanilla] CHECK CONSTRAINT [FK_MovPlanilla_TipoMovPlantilla]
GO
ALTER TABLE [dbo].[MovVacacional]  WITH CHECK ADD  CONSTRAINT [FK_MovVacacional_Debito] FOREIGN KEY([IdDebito])
REFERENCES [dbo].[Debito] ([Id])
GO
ALTER TABLE [dbo].[MovVacacional] CHECK CONSTRAINT [FK_MovVacacional_Debito]
GO
ALTER TABLE [dbo].[MovVacacional]  WITH CHECK ADD  CONSTRAINT [FK_MovVacacional_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[MovVacacional] CHECK CONSTRAINT [FK_MovVacacional_Empleado]
GO
ALTER TABLE [dbo].[MovVacacional]  WITH CHECK ADD  CONSTRAINT [FK_MovVacacional_TipoMovVac] FOREIGN KEY([IdTipoMovVac])
REFERENCES [dbo].[TipoMovVac] ([Id])
GO
ALTER TABLE [dbo].[MovVacacional] CHECK CONSTRAINT [FK_MovVacacional_TipoMovVac]
GO
ALTER TABLE [dbo].[PlanillaMesXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaMesXEmpleado_MesPlanilla] FOREIGN KEY([IdMesPlanilla])
REFERENCES [dbo].[MesPlanilla] ([Id])
GO
ALTER TABLE [dbo].[PlanillaMesXEmpleado] CHECK CONSTRAINT [FK_PlanillaMesXEmpleado_MesPlanilla]
GO
ALTER TABLE [dbo].[PlanillaSemXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaSemXEmpleado_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[PlanillaSemXEmpleado] CHECK CONSTRAINT [FK_PlanillaSemXEmpleado_Empleado]
GO
ALTER TABLE [dbo].[PlanillaSemXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_PlanillaSemXEmpleado_SemanaPlanilla] FOREIGN KEY([IdPlanillaSem])
REFERENCES [dbo].[SemanaPlanilla] ([Id])
GO
ALTER TABLE [dbo].[PlanillaSemXEmpleado] CHECK CONSTRAINT [FK_PlanillaSemXEmpleado_SemanaPlanilla]
GO
ALTER TABLE [dbo].[SemanaPlanilla]  WITH CHECK ADD  CONSTRAINT [FK_SemanaPlanilla_MesPlanilla] FOREIGN KEY([idMesPlanilla])
REFERENCES [dbo].[MesPlanilla] ([Id])
GO
ALTER TABLE [dbo].[SemanaPlanilla] CHECK CONSTRAINT [FK_SemanaPlanilla_MesPlanilla]
GO
ALTER TABLE [dbo].[TipoDeduccion]  WITH CHECK ADD  CONSTRAINT [FK_TipoDeduccion_DeduccionPorcentualObligatoria] FOREIGN KEY([IdDeduccionObligatoria])
REFERENCES [dbo].[DeduccionPorcentualObligatoria] ([Id])
GO
ALTER TABLE [dbo].[TipoDeduccion] CHECK CONSTRAINT [FK_TipoDeduccion_DeduccionPorcentualObligatoria]
GO
ALTER TABLE [dbo].[TipoMovDeduccion]  WITH CHECK ADD  CONSTRAINT [FK_TipoMovDeduccion_TipoDeduccion] FOREIGN KEY([idTipoDeduccion])
REFERENCES [dbo].[TipoDeduccion] ([Id])
GO
ALTER TABLE [dbo].[TipoMovDeduccion] CHECK CONSTRAINT [FK_TipoMovDeduccion_TipoDeduccion]
GO
ALTER TABLE [dbo].[TipoMovPlantilla]  WITH CHECK ADD  CONSTRAINT [FK_TipoMovPlantilla_TipoMovDeduccion] FOREIGN KEY([IdTipoMovDeduccion])
REFERENCES [dbo].[TipoMovDeduccion] ([Id])
GO
ALTER TABLE [dbo].[TipoMovPlantilla] CHECK CONSTRAINT [FK_TipoMovPlantilla_TipoMovDeduccion]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Empleado1] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Empleado1]
GO
/****** Object:  StoredProcedure [dbo].[BorrarDatos]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BorrarDatos]
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM [dbo].[PlanillaMesXEmpleado]--Limpia la tabla empelados*/
	DBCC CHECKIDENT ('[PlanillaMesXEmpleado]', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM [dbo].[MarcarAsistencia]--Limpia la tabla empelados*/
	DBCC CHECKIDENT ('[MarcarAsistencia]', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM dbo.Jornada
	DBCC CHECKIDENT ('Jornada', RESEED, 0)
	
	DELETE FROM [dbo].[PlanillaSemXEmpleado]--Limpia la tabla empelados*/
	DBCC CHECKIDENT ('[PlanillaSemXEmpleado]', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM[dbo].[SemanaPlanilla]
	DBCC CHECKIDENT ('[SemanaPlanilla]', RESEED, 0)

	DELETE FROM [dbo].[MesPlanilla]
	DBCC CHECKIDENT ('[MesPlanilla]', RESEED, 0)

	DELETE FROM [dbo].[MovPlanilla]--Limpia la tabla empelados*/
	DBCC CHECKIDENT ('[MovPlanilla]', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM dbo.Usuario/*Limpia la tabla empelados*/
	DBCC CHECKIDENT ('Usuario', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM dbo.DeduccionXEmpleado/*Limpia la tabla empelados*/
	DBCC CHECKIDENT ('DeduccionXEmpleado', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM FijaNoObligatoria
	DBCC CHECKIDENT ('FijaNoObligatoria', RESEED, 0)

	DELETE FROM dbo.Empleado/*Limpia la tabla empelados*/
	DBCC CHECKIDENT ('Empleado', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM	[dbo].[FijaNoObligatoria]
	DBCC CHECKIDENT ('[FijaNoObligatoria]', RESEED, 0)

	DELETE FROM dbo.TipoDocuIdentidad/*Limpia la tabla empelados*/

	DELETE FROM dbo.Departamento/*Limpia la tabla empelados*/

	DELETE FROM dbo.Puesto/*Limpia la tabla empelados*/

	DELETE FROM dbo.Feriado/*Limpia la tabla empelados*/
	DBCC CHECKIDENT ('Feriado', RESEED, 0)/*Reinicia el identify*/

	DELETE FROM dbo.TipoJornada

	DELETE FROM TipoDeduccion

	DELETE FROM [dbo].[DeduccionPorcentualObligatoria]
	DBCC CHECKIDENT ('[DeduccionPorcentualObligatoria]', RESEED, 0)/*Reinicia el identify*/

DELETE FROM [TipoMovPlantilla]





















	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[cargarDatosCatalogo]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cargarDatosCatalogo]
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @Porcentajes TABLE (
		Sec INT IDENTITY(1,1),
		Valor FLOAT
	)

	DECLARE @xmlData XML
	SET @xmlData = (
	SELECT *
	FROM OPENROWSET(BULK 'C:\Users\david\Desktop\ProyectoBD\Datos_Tarea3.xml', SINGLE_BLOB) 
	AS xmlData
	);
	
	INSERT INTO @Porcentajes
	SELECT T.Item.value('@Valor', 'FLOAT') AS Valor
	FROM @xmlData.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') as T(Item)	

--TipoDocuIdentidad
	INSERT INTO dbo.TipoDocuIdentidad(Id, Nombre)
	SELECT  T.Item.value('@Id', 'INT'),
			T.Item.value('@Nombre', 'VARCHAR(64)')
	FROM @xmlData.nodes('Datos/Catalogos/Tipos_de_Documento_de_Identificacion/TipoIdDoc') as T(Item)



--Puestos
	INSERT INTO dbo.Puesto(Id,Nombre,SalarioXHora)
	SELECT  T.Item.value('@Id', 'INT'),
			T.Item.value('@Nombre', 'VARCHAR(64)'),
			T.Item.value('@SalarioXHora', 'MONEY')
	FROM @xmlData.nodes('Datos/Catalogos/Puestos/Puesto') AS T(Item)

--Departamentos
	INSERT INTO dbo.Departamento(Id,Nombre)
	SELECT  T.Item.value('@Id', 'INT'),
			T.Item.value('@Nombre', 'VARCHAR(64)')
	FROM @xmlData.nodes('Datos/Catalogos/Departamentos/Departamento') AS T(Item)


--Usuarios
	INSERT INTO dbo.Usuario(Password,
		EsAdministrador,
		Nombre
		)
	SELECT  T.Item.value('@pwd', 'VARCHAR(64)'),
			T.Item.value('@tipo', 'BIT'),
			T.Item.value('@username', 'VARCHAR(64)')
	FROM @xmlData.nodes('Datos/Usuarios/Usuario') AS T(Item)



----TipoJornada
	INSERT INTO dbo.TipoJornada
	SELECT  T.Item.value('@Id', 'INT') AS Id,
			T.Item.value('@Nombre', 'VARCHAR(64)') AS Nombre,
			T.Item.value('@HoraEntrada', 'time(0)') AS HoraInicio,
			T.Item.value('@HoraSalida', 'time(0)') AS HoraFin
	FROM @xmlData.nodes('Datos/Catalogos/TiposDeJornada/TipoDeJornada') AS T(Item)





	INSERT INTO dbo.Feriado
	SELECT  T.Item.value('@Fecha','Date') as Fecha,
			T.Item.value('@Nombre', 'VARCHAR(64)') AS Nombre
	FROM @xmlData.nodes('Datos/Catalogos/Feriados/Feriado') AS T(Item) 


--movimientos






	INSERT INTO dbo.DeduccionPorcentualObligatoria
	SELECT P.Valor AS [Porcentaje]
	FROM @Porcentajes P



	DELETE T
	FROM
	(
	SELECT *
	, DupRank = ROW_NUMBER() OVER (
				  PARTITION BY [Porcentaje]
				  ORDER BY (SELECT NULL)
				)
	FROM dbo.DeduccionPorcentualObligatoria A
	) AS T
	WHERE DupRank > 1 




	INSERT INTO dbo.TipoDeduccion
	SELECT  T.Item.value('@Id', 'INT') AS Id,
			T.Item.value('@Nombre', 'VARCHAR(64)') AS Nombre,
			T.Item.value('@Obligatorio', 'varchar(64)') AS [EsObligatorio],
			T.Item.value('@Porcentual', 'varchar(64)') AS [EsPorcentual],
			e.ID AS [IdDeduccionObligatoria]
	FROM @xmlData.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') AS T(Item)
	INNER JOIN dbo.DeduccionPorcentualObligatoria E 
	ON e.Porcentaje= T.Item.value('@Valor', 'FLOAT') 
	WHERE E.Porcentaje = T.Item.value('@Valor', 'FLOAT')


	INSERT INTO [dbo].[TipoMovPlantilla](Id,Nombre)
	SELECT  T.Item.value('@Id', 'INT') AS Id,
			T.Item.value('@Nombre', 'VARCHAR(64)') AS Nombre
	FROM @xmlData.nodes('Datos/Catalogos/TiposDeMovimiento/TipoDeMovimiento') AS T(Item)

	SET NOCOUNT OFF;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_PlanillaMensual]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PlanillaMensual]
	-- Parametros de entrada
	@InEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.Empleado WHERE Id = @InEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END

		SELECT TOP(12)
			PMes.Id,
			PMes.SalarioTotal,
			PMes.SalarioNeto,
			PMes.SalarioTotal - PMes.SalarioNeto AS TotalDeducciones
		FROM [dbo].[PlanillaMesXEmpleado] AS PMes
		WHERE PMes.IdEmpleado = @InEmpleado
		ORDER BY (PMes.Id)DESC

	END TRY
	BEGIN CATCH

		SET @OutResultCode = 501;				-- No se inserto en la tabla

	END CATCH

	SET NOCOUNT OFF

END
GO
/****** Object:  StoredProcedure [dbo].[sp_PlanillaSemanal]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PlanillaSemanal]
	-- Parametros de entrada
	@InEmpleado INT,

	-- Parametros de salida
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SET @OutResultCode = 0

		IF NOT EXISTS (SELECT 1 FROM dbo.Empleado WHERE Id = @InEmpleado)
		BEGIN
			SET @OutResultCode = 5001			-- Error por si no encuentra el empleado
			RETURN
		END
		
		SELECT TOP(15)
			Planilla.Id,
			Planilla.TotalSalarioBruto,
			Planilla.SalarioNeto,
			Planilla.TotalSalarioBruto - Planilla.SalarioNeto AS TotalDeducciones
		FROM [dbo].[PlanillaSemXEmpleado] AS Planilla
		WHERE IdEmpleado = @InEmpleado
		ORDER BY (Id)DESC


	END TRY
	BEGIN CATCH
		SET @OutResultCode = 501;				-- No se inserto en la tabla
	END CATCH

	SET NOCOUNT OFF

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarUsuario]    Script Date: 07/06/2022 12:36:44 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarUsuario]
-- parametros de entrada
	@innombre VARCHAR(64),
	@incontrasena VARCHAR(64),

-- parametros de salida
	@OutResultCode INT OUTPUT
	
	AS
	BEGIN
		SET NOCOUNT ON;
		BEGIN TRY
			SELECT
				@OutResultCode=0  -- codigo de ejecucion exitoso

			SELECT * FROM dbo.Usuario
			WHERE Nombre = @innombre
			AND Password = @incontrasena
		END TRY
		BEGIN CATCH
			Set @OutResultCode=50005; -- error de ejecucion
		END CATCH;
		SET NOCOUNT OFF;
END
GO
USE [master]
GO
ALTER DATABASE [tareaBD3] SET  READ_WRITE 
GO
