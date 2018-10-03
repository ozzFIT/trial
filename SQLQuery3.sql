
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/30/2018 23:17:49
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
IF OBJECT_ID(N'[dbo].[FK_EventComments]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_EventComments];
GO
IF OBJECT_ID(N'[dbo].[FK_UserComments]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_UserComments];
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
    [UserUserId] int  NOT NULL,
    [LikeCount] bigint  NOT NULL,
    [DislikeCount] bigint  NOT NULL
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

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [CommentId] int IDENTITY(1,1) NOT NULL,
    [CDescription] nvarchar(max)  NOT NULL,
    [CDateTime] nvarchar(max)  NOT NULL,
    [EventEventId] int  NOT NULL,
    [UserUserId] int  NOT NULL
);
GO

-- Creating table 'Entity1'
CREATE TABLE [dbo].[Entity1] (
    [Id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'Likes'
CREATE TABLE [dbo].[Likes] (
    [likeId] int IDENTITY(1,1) NOT NULL,
    [Islike] bit  NOT NULL,
    [UserUserId] int  NOT NULL,
    [EventEventId] int  NOT NULL
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

-- Creating primary key on [CommentId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([CommentId] ASC);
GO

-- Creating primary key on [Id] in table 'Entity1'
ALTER TABLE [dbo].[Entity1]
ADD CONSTRAINT [PK_Entity1]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [likeId] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [PK_Likes]
    PRIMARY KEY CLUSTERED ([likeId] ASC);
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

-- Creating foreign key on [UserUserId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_UserComments]
    FOREIGN KEY ([UserUserId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserComments'
CREATE INDEX [IX_FK_UserComments]
ON [dbo].[Comments]
    ([UserUserId]);
GO

-- Creating foreign key on [UserUserId] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [FK_UserLikes]
    FOREIGN KEY ([UserUserId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserLikes'
CREATE INDEX [IX_FK_UserLikes]
ON [dbo].[Likes]
    ([UserUserId]);
GO

-- Creating foreign key on [EventEventId] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [FK_EventLikes]
    FOREIGN KEY ([EventEventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_EventLikes'
CREATE INDEX [IX_FK_EventLikes]
ON [dbo].[Likes]
    ([EventEventId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------