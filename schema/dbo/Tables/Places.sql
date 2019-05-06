CREATE TABLE [dbo].[Places] (
    [Id]          INT              IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255)   NULL,
    [Address]     NVARCHAR (255)   NULL,
    [Latitude]    DECIMAL (22, 15) NULL,
    [Longitude]   DECIMAL (22, 15) NULL,
    [Image]       VARBINARY (MAX)  NULL,
    [IsShared]    BIT              CONSTRAINT [DF_Places_IsShared] DEFAULT ((0)) NULL,
    [UserName]    NVARCHAR (256)   NULL,
    [Description] VARCHAR (255)    NULL,
    [Capacity]    SMALLINT         NULL,
    CONSTRAINT [PK_Places] PRIMARY KEY CLUSTERED ([Id] ASC)
);









