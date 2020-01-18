CREATE DATABASE [C5]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'C5', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\C5.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'C5_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\C5_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [C5] SET COMPATIBILITY_LEVEL = 140
GO
ALTER DATABASE [C5] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [C5] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [C5] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [C5] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [C5] SET ARITHABORT OFF 
GO
ALTER DATABASE [C5] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [C5] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [C5] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [C5] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [C5] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [C5] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [C5] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [C5] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [C5] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [C5] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [C5] SET  DISABLE_BROKER 
GO
ALTER DATABASE [C5] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [C5] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [C5] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [C5] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [C5] SET  READ_WRITE 
GO
ALTER DATABASE [C5] SET RECOVERY FULL 
GO
ALTER DATABASE [C5] SET  MULTI_USER 
GO
ALTER DATABASE [C5] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [C5] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [C5] SET DELAYED_DURABILITY = DISABLED 
GO
USE [C5]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [C5]
GO
IF NOT EXISTS (SELECT name
FROM sys.filegroups
WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [C5] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO


CREATE TABLE PolitischeOrientierung
(
    id int NOT NULL,
    Ausrichtung varchar(100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Verdächtigungsgrad
(
    id int NOT NULL,
    Verdächtigungsgrad int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Region
(
    id int NOT NULL,
    FK_Region varchar (100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Gruppen
(
    id int NOT NULL,
    Name varchar(100),
    FK_Verdächtigungsgrad int,
    FK_PolitischeOrientierung int,
    FK_Region int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Mission
(
    id int NOT NULL,
    idHash varchar(100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Klassifizierungsgrad
(
    id int NOT NULL,
    Klassifizierungsgrad varchar(2),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Whitelist
(
    id int NOT NULL,
    Callsign varchar(50),
    Vorname varchar(50),
    Nachname varchar(50),
    FK_Aufenthaltsort int,
    FK_Wohnort int,
    FK_Mission int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Verdächtige
(
    id int NOT NULL,
    Pseudonym varchar(50),
    Vorname varchar(50),
    Nachname varchar(50),
    FK_Aufenthaltsort int,
    FK_Kommunikation int,
    FK_Verdächtigungsgrad int NOT NULL,
    FK_Gruppen int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Kommunikation
(
    id int NOT NULL,
    StandartisierterInhalt varchar,
    OriginalInhalt varbinary(MAX) NOT NULL,
    FK_Kommunikationsart int NOT NULL,
    FK_Verdächtigungsgrad int,
    FK_Sender int,
    FK_SenderOrt int,
    FK_Empfänger int,
    FK_EmpfängerOrt int,
    FK_Sprache int,
    FK_Schlüsselwörter int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Kommunikationsart
(
    id int NOT NULL,
    Kommunkationsart varchar(50),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Sprache
(
    id int NOT NULL,
    Sprache varchar(100),
    Dialekt varchar(100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Schlüsselwort
(
    id int NOT NULL,
    Wortbedeutung varchar(200),
    Wort varchar(200),
    FK_Sprache int NOT NULL,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Ort
(
    id int NOT NULL,
    StrasseUndNummer varchar(200),
    FK_Postleitzahl int,
    FK_Ortsname int,
    FK_KantonBundesstaat int,
    FK_Land int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Postleitzahl
(
    id int NOT NULL,
    Postleitzahl int,
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Ortsname
(
    id int NOT NULL,
    Ortsname varchar(100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE KantonBundesstaat
(
    id int NOT NULL,
    KantonBundesstaat varchar(100),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Land
(
    id int NOT NULL,
    Land varchar(50),
    FK_Klassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

/* implement 1:1 relationship, ensure that FK_Klassifizierungsgrad always has the same value as in Og*/
ALTER TABLE PolitischeOrientierung ADD CONSTRAINT FK_Klassifizierungsgrad  FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Verdächtigungsgrad ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Region ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Gruppen ADD CONSTRAINT FK_Verdächtigungsgrad FOREIGN KEY (id) REFERENCES Verdächtigungsgrad(id)
ALTER TABLE Gruppen ADD CONSTRAINT FK_PolitischeOrientierung FOREIGN KEY (id) REFERENCES PolitischeOrientierung(id)
ALTER TABLE Gruppen ADD CONSTRAINT FK_Region FOREIGN KEY (id) REFERENCES REGION(id)
ALTER TABLE Gruppen ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Mission ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Whitelist ADD CONSTRAINT FK_Mission FOREIGN KEY (id) REFERENCES Mission
ALTER TABLE Whitelist ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Verdächtige ADD CONSTRAINT FK_Verdächtigungsgrad FOREIGN KEY (id) REFERENCES Verdächtigungsgrad(id)
ALTER TABLE Verdächtige ADD CONSTRAINT FK_Gruppen FOREIGN KEY (id) REFERENCES Gruppen(id)
ALTER TABLE Verdächtige ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Sprache ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Schlüsselwort ADD CONSTRAINT FK_Sprache FOREIGN KEY (id) REFERENCES Sprache(id)
ALTER TABLE Schlüsselwort ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Ort ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Postleitzahl ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Ortsname ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE KantonBundesstaat ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)

ALTER TABLE Land ADD CONSTRAINT FK_Klassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)







