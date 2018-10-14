
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/09/2018 13:48:25
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

IF OBJECT_ID(N'[dbo].[FK_UserEventMember]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventMembers] DROP CONSTRAINT [FK_UserEventMember];
GO
IF OBJECT_ID(N'[dbo].[FK_EventEventMember]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventMembers] DROP CONSTRAINT [FK_EventEventMember];
GO
IF OBJECT_ID(N'[dbo].[FK_EventEmail]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Emails] DROP CONSTRAINT [FK_EventEmail];
GO
IF OBJECT_ID(N'[dbo].[FK_EventComments]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_EventComments];
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
IF OBJECT_ID(N'[dbo].[EventMembers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventMembers];
GO
IF OBJECT_ID(N'[dbo].[Emails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Emails];
GO
IF OBJECT_ID(N'[dbo].[Comments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Comments];
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
    [DateOfBirth] datetime  NULL
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
    [LikeCount] bigint  NOT NULL,
    [DislikeCount] bigint  NOT NULL
);
GO

-- Creating table 'EventMembers'
CREATE TABLE [dbo].[EventMembers] (
    [UserUserId] int  NOT NULL,
    [EventEventId] int  NOT NULL
);
GO

-- Creating table 'Emails'
CREATE TABLE [dbo].[Emails] (
    [EmailId] int IDENTITY(1,1) NOT NULL,
    [ToEmail] nvarchar(max)  NOT NULL,
    [Subject] nvarchar(max)  NOT NULL,
    [Contents] nvarchar(max)  NOT NULL,
    [EventEventId] int  NOT NULL
);
GO

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [CId] int IDENTITY(1,1) NOT NULL,
    [CDescription] nvarchar(max)  NOT NULL,
    [CDateTime] datetime  NOT NULL,
    [EventEventId] int  NULL
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

-- Creating primary key on [EventEventId], [UserUserId] in table 'EventMembers'
ALTER TABLE [dbo].[EventMembers]
ADD CONSTRAINT [PK_EventMembers]
    PRIMARY KEY CLUSTERED ([EventEventId], [UserUserId] ASC);
GO

-- Creating primary key on [EmailId] in table 'Emails'
ALTER TABLE [dbo].[Emails]
ADD CONSTRAINT [PK_Emails]
    PRIMARY KEY CLUSTERED ([EmailId] ASC);
GO

-- Creating primary key on [CId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([CId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

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

-- Creating foreign key on [EventEventId] in table 'Emails'
ALTER TABLE [dbo].[Emails]
ADD CONSTRAINT [FK_EventEmail]
    FOREIGN KEY ([EventEventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventEmail'
CREATE INDEX [IX_FK_EventEmail]
ON [dbo].[Emails]
    ([EventEventId]);
GO

-- Creating foreign key on [EventEventId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_EventComments]
    FOREIGN KEY ([EventEventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventComments'
CREATE INDEX [IX_FK_EventComments]
ON [dbo].[Comments]
    ([EventEventId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------