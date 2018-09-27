
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/10/2018 21:15:31
-- Generated from EDMX file: \\ad.monash.edu\home\User039\aram0008\Desktop\IAD\Assignment\V2\FIT5032_ozzFIT_V2\FIT5032_ozzFIT_V2\Models\UserDatabaseModel1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [UserDatabaseModel1];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_EventEventReport]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventReports] DROP CONSTRAINT [FK_EventEventReport];
GO
IF OBJECT_ID(N'[dbo].[FK_UserEventMember]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventMembers] DROP CONSTRAINT [FK_UserEventMember];
GO
IF OBJECT_ID(N'[dbo].[FK_EventEventMember]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventMembers] DROP CONSTRAINT [FK_EventEventMember];
GO
IF OBJECT_ID(N'[dbo].[FK_EventMemberRSVP]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RSVPs] DROP CONSTRAINT [FK_EventMemberRSVP];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Events];
GO
IF OBJECT_ID(N'[dbo].[EventReports]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventReports];
GO
IF OBJECT_ID(N'[dbo].[EventMembers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventMembers];
GO
IF OBJECT_ID(N'[dbo].[RSVPs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RSVPs];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL,
    [ZipCode] smallint  NOT NULL,
    [Height] nvarchar(max)  NULL,
    [Weight] nvarchar(max)  NULL,
    [Gender] nvarchar(max)  NOT NULL,
    [DateOfBirth] nvarchar(max)  NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [EventId] int IDENTITY(1,1) NOT NULL,
    [EventName] nvarchar(max)  NOT NULL,
    [EventDescription] nvarchar(max)  NULL,
    [Location] nvarchar(max)  NOT NULL,
    [StartDateTime] datetime  NOT NULL,
    [EndDateTime] datetime  NOT NULL,
    [ContactPerson] nvarchar(max)  NOT NULL,
    [ContactDetails] nvarchar(max)  NOT NULL,
    [UserUserId] int  NOT NULL
);
GO

-- Creating table 'EventReports'
CREATE TABLE [dbo].[EventReports] (
    [EventReportId] int IDENTITY(1,1) NOT NULL,
    [EventName] nvarchar(max)  NOT NULL,
    [ReportDescription] nvarchar(max)  NOT NULL,
    [ReportMedia] bit  NULL,
    [Event_EventId] int  NOT NULL
);
GO

-- Creating table 'EventMembers'
CREATE TABLE [dbo].[EventMembers] (
    [UserUserId] int  NOT NULL,
    [EventEventId] int  NOT NULL
);
GO

-- Creating table 'RSVPs'
CREATE TABLE [dbo].[RSVPs] (
    [RSVPId] int IDENTITY(1,1) NOT NULL,
    [RSVPStatus] nvarchar(max)  NOT NULL,
    [NumOfGuests] bigint  NOT NULL,
    [EventMemberEventEventId] int  NOT NULL,
    [EventMemberUserUserId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [UserId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [EventId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([EventId] ASC);
GO

-- Creating primary key on [EventReportId] in table 'EventReports'
ALTER TABLE [dbo].[EventReports]
ADD CONSTRAINT [PK_EventReports]
    PRIMARY KEY CLUSTERED ([EventReportId] ASC);
GO

-- Creating primary key on [EventEventId], [UserUserId] in table 'EventMembers'
ALTER TABLE [dbo].[EventMembers]
ADD CONSTRAINT [PK_EventMembers]
    PRIMARY KEY CLUSTERED ([EventEventId], [UserUserId] ASC);
GO

-- Creating primary key on [RSVPId] in table 'RSVPs'
ALTER TABLE [dbo].[RSVPs]
ADD CONSTRAINT [PK_RSVPs]
    PRIMARY KEY CLUSTERED ([RSVPId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Event_EventId] in table 'EventReports'
ALTER TABLE [dbo].[EventReports]
ADD CONSTRAINT [FK_EventEventReport]
    FOREIGN KEY ([Event_EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventEventReport'
CREATE INDEX [IX_FK_EventEventReport]
ON [dbo].[EventReports]
    ([Event_EventId]);
GO

-- Creating foreign key on [UserUserId] in table 'EventMembers'
ALTER TABLE [dbo].[EventMembers]
ADD CONSTRAINT [FK_UserEventMember]
    FOREIGN KEY ([UserUserId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserEventMember'
CREATE INDEX [IX_FK_UserEventMember]
ON [dbo].[EventMembers]
    ([UserUserId]);
GO

-- Creating foreign key on [EventEventId] in table 'EventMembers'
ALTER TABLE [dbo].[EventMembers]
ADD CONSTRAINT [FK_EventEventMember]
    FOREIGN KEY ([EventEventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [EventMemberEventEventId], [EventMemberUserUserId] in table 'RSVPs'
ALTER TABLE [dbo].[RSVPs]
ADD CONSTRAINT [FK_EventMemberRSVP]
    FOREIGN KEY ([EventMemberEventEventId], [EventMemberUserUserId])
    REFERENCES [dbo].[EventMembers]
        ([EventEventId], [UserUserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventMemberRSVP'
CREATE INDEX [IX_FK_EventMemberRSVP]
ON [dbo].[RSVPs]
    ([EventMemberEventEventId], [EventMemberUserUserId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------