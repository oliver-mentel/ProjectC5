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
    FK_PolitischeOrientierungKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Verdächtigungsgrad
(
    id int NOT NULL,
    Verdächtigungsgrad int,
    FK_VerdächtigungsgradKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Region
(
    id int NOT NULL,
    Region varchar (100),
    FK_RegionKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Gruppen
(
    id int NOT NULL,
    Name varchar(100),
    FK_GruppenVerdächtigungsgrad int,
    FK_GruppenPolitischeOrientierung int,
    FK_GruppenRegion int,
    FK_GruppenKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)
CREATE TABLE GruppenOrientierung
(
    id int NOT NULL,
    FK_GruppenOrientierungGruppen int,
    FK_GruppenOrientierungPolitischeOrientierung int,
    PRIMARY KEY (id),
)
CREATE TABLE GruppenRegion
(
    id int NOT NULL,
    FK_GruppenRegionGruppen int,
    FK_GruppenRegionRegion int,
    PRIMARY KEY (id),
)

CREATE TABLE Mission
(
    id int NOT NULL,
    idHash varchar(100),
    FK_MissionKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Klassifizierungsgrad
(
    id int NOT NULL,
    Klassifizierungsgrad varchar(2),
    FK_KlassifizierungsgradKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Whitelist
(
    id int NOT NULL,
    Callsign varchar(50),
    Vorname varchar(50),
    Nachname varchar(50),
    FK_WhitelistAufenthaltsort int,
    FK_WhitelistMission int,
    FK_WhitelistKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Verdächtige
(
    id int NOT NULL,
    Pseudonym varchar(50),
    Vorname varchar(50),
    Nachname varchar(50),
    FK_VerdächtigeAufenthaltsort int,
    FK_VerdächtigeKommunikation int,
    FK_VerdächtigeVerdächtigungsgrad int NOT NULL,
    FK_VerdächtigeGruppen int,
    FK_VerdächtigeKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)
CREATE TABLE VerdächtigeKommunikation
(
    id int NOT NULL,
    FK_VerdächtigeKommunikationVerdächtige int,
    FK_VerdächtigeKommunikationKommunikation int,
    PRIMARY KEY (id),
)
CREATE TABLE VerdächtigeGruppe
(
    id int NOT NULL,
    FK_VerdächtigeGruppeVerdächtige int,
    FK_VerdächtigeGruppeGruppe int,
    PRIMARY KEY (id),
)

CREATE TABLE Kommunikation
(
    id int NOT NULL,
    StandartisierterInhalt varchar,
    OriginalInhalt varbinary(MAX) NOT NULL,
    FK_KommunikationKommunikationsart int NOT NULL,
    FK_KommunikationVerdächtigungsgrad int,
    FK_KommunikationVerdächtigerSender int,
    FK_KommunikationOrtSender int,
    FK_KommunikationVerdächtigerEmpfänger int,
    FK_KommunikationOrtEmpfänger int,
    FK_KommunikationSprache int,
    FK_KommunikationSchlüsselwort int,
    FK_KommunikationKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)
CREATE TABLE KommunikationSender
(
    id int NOT NULL,
    FK_KommunikationSenderKommunikation int,
    FK_KommunikationSenderSender int,
    PRIMARY KEY (id),
)
CREATE TABLE KommunikationEmpfänger
(
    id int NOT NULL,
    FK_KommunikationEmpfängerKommunikation int,
    FK_KommunikationEmpfängerEmpfänger int,
    PRIMARY KEY (id),
)
CREATE TABLE KommunikationSprache
(
    id int NOT NULL,
    FK_KommunikationSpracheKommunikation int,
    FK_KommunikationSpracheSprache int,
    PRIMARY KEY (id),
)
CREATE TABLE KommunikationSchlüsselwort
(
    id int NOT NULL,
    FK_KommunikationSchlüsselwortKommunikation int,
    FK_KommunikationSchlüsselwortSchlüsselwort int,
    PRIMARY KEY (id),
)

CREATE TABLE Kommunikationsart
(
    id int NOT NULL,
    Kommunkationsart varchar(50),
    FK_KommunikationsartKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Sprache
(
    id int NOT NULL,
    Sprache varchar(100),
    Dialekt varchar(100),
    FK_SpracheKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Schlüsselwort
(
    id int NOT NULL,
    Wortbedeutung varchar(200),
    Wort varchar(200),
    FK_SchlüsselwortSprache int NOT NULL,
    FK_SchlüsselwortKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Ort
(
    id int NOT NULL,
    StrasseUndNummer varchar(200),
    FK_OrtPostleitzahl int,
    FK_OrtOrtsname int,
    FK_OrtKantonBundesstaat int,
    FK_OrtLand int,
    FK_OrtKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Postleitzahl
(
    id int NOT NULL,
    Postleitzahl int,
    FK_PostleitzahlKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Ortsname
(
    id int NOT NULL,
    Ortsname varchar(100),
    FK_OrtsnameKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE KantonBundesstaat
(
    id int NOT NULL,
    KantonBundesstaat varchar(100),
    FK_KantonBundesstaatKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

CREATE TABLE Land
(
    id int NOT NULL,
    Land varchar(50),
    FK_LandKlassifizierungsgrad int NOT NULL,
    PRIMARY KEY (id),
)

/* implement relationships and RIB*/
ALTER TABLE PolitischeOrientierung ADD CONSTRAINT FK_PolitischeOrientierungKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Verdächtigungsgrad ADD CONSTRAINT FK_VerdächtigungsgradKlassifizierungsgrads FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Region ADD CONSTRAINT FK_RegionKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Gruppen ADD CONSTRAINT FK_GruppenVerdächtigungsgrad FOREIGN KEY (id) REFERENCES Verdächtigungsgrad(id)
ALTER TABLE Gruppen ADD CONSTRAINT FK_GruppenKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE GruppenOrientierung ADD CONSTRAINT FK_GruppenOrientierungGruppen FOREIGN KEY (id) REFERENCES Gruppen
/*ALTER TABLE GruppenOrientierung ADD CONSTRAINT FK_GruppenOrientierungPolitischeOrientierung (id) REFERENCES PolitischeOrientierung(id) need to check this again later, no idea why it doesnt work*/
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE GruppenRegion ADD CONSTRAINT FK_GruppenRegionGruppen FOREIGN KEY (id) REFERENCES Gruppen(id)
ALTER TABLE GruppenRegion ADD CONSTRAINT FK_GruppenRegionRegion FOREIGN KEY (id) REFERENCES Region(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Mission ADD CONSTRAINT FK_MissionKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Whitelist ADD CONSTRAINT FK_WhitelistAufenthaltsort FOREIGN KEY (id) REFERENCES Ort(id)
ALTER TABLE Whitelist ADD CONSTRAINT FK_WhitelistMission FOREIGN KEY (id) REFERENCES Mission
ALTER TABLE Whitelist ADD CONSTRAINT FK_WhitelistKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Verdächtige ADD CONSTRAINT FK_VerdächtigeAufenthaltsort FOREIGN KEY (id) REFERENCES Ort(id)
ALTER TABLE Verdächtige ADD CONSTRAINT FK_VerdächtigeVerdächtigungsgrad FOREIGN KEY (id) REFERENCES Verdächtigungsgrad(id)
ALTER TABLE Verdächtige ADD CONSTRAINT FK_VerdächtigeKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE VerdächtigeKommunikation ADD CONSTRAINT FK_VerdächtigeKommunikationVerdächtige FOREIGN KEY (id) REFERENCES Verdächtige(id)
ALTER TABLE VerdächtigeKommunikation ADD CONSTRAINT FK_VerdächtigeKommunikationKommunikation FOREIGN KEY (id) REFERENCES Kommunikation(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE VerdächtigeGruppe ADD CONSTRAINT FK_VerdächtigeGruppeVerdächtige FOREIGN KEY (id) REFERENCES Verdächtige(id)
ALTER TABLE VerdächtigeGruppe ADD CONSTRAINT FK_VerdächtigeGruppeGruppe FOREIGN KEY (id) REFERENCES Gruppen(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Sprache ADD CONSTRAINT FK_SpracheKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Schlüsselwort ADD CONSTRAINT FK_SchlüsselwortSprache FOREIGN KEY (id) REFERENCES Sprache(id)
ALTER TABLE Schlüsselwort ADD CONSTRAINT FK_SchlüsselwortKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Ort ADD CONSTRAINT FK_OrtPostleitzahl FOREIGN KEY (id) REFERENCES Postleitzahl(id)
ALTER TABLE Ort ADD CONSTRAINT FK_OrtOrtsname FOREIGN KEY (id) REFERENCES Ortsname(id)
ALTER TABLE Ort ADD CONSTRAINT FK_OrtKantonBundesstaat FOREIGN KEY (id) REFERENCES KantonBundesstaat(id)
ALTER TABLE Ort ADD CONSTRAINT FK_OrtLand FOREIGN KEY (id) REFERENCES Land(id)
ALTER TABLE Ort ADD CONSTRAINT FK_OrtKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Postleitzahl ADD CONSTRAINT FK_PostleitzahlKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Ortsname ADD CONSTRAINT FK_OrtsnameKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE KantonBundesstaat ADD CONSTRAINT FK_KantonBundesstaatKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Land ADD CONSTRAINT FK_LandKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Kommunikation ADD CONSTRAINT FK_KommunikationKommunikationsart FOREIGN KEY (id) REFERENCES Kommunikationsart(id)
ALTER TABLE Kommunikation ADD CONSTRAINT FK_KommunikationVerdächtigungsgrad FOREIGN KEY (id) REFERENCES Verdächtigungsgrad(id)
ALTER TABLE Kommunikation ADD CONSTRAINT FK_KommunikationOrtSender FOREIGN KEY (id) REFERENCES Ort(id)
ALTER TABLE Kommunikation ADD CONSTRAINT FK_KommunikationVerdächtigerEmpfänger FOREIGN KEY (id) REFERENCES Verdächtige(id)
ALTER TABLE Kommunikation ADD CONSTRAINT FK_KommunikationKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE Kommunikationsart ADD CONSTRAINT FK_KommunikationsartKlassifizierungsgrad FOREIGN KEY (id) REFERENCES Klassifizierungsgrad(id)
ON DELETE CASCADE
ON UPDATE CASCADE




/* todo
Zwischentabellen:
Kommunikation:Sender n:1 KommunikationSender
Kommunikation:Empfänger n:1 KommunikationEmpfänger
Kommunikation:Sprache n:n KommunikationSprache
Kommunikation:Schlüsselwörter n:n KommunikationSchlüsselwort

RIBs/Cascade überprüfen ob Sinnvoll

gg Bewertungsraster schauen */