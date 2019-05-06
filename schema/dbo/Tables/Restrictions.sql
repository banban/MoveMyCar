CREATE TABLE [dbo].[Restrictions] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (255)   NULL,
    [Image]       VARBINARY (MAX) NULL,
    CONSTRAINT [PK_Restrictions] PRIMARY KEY CLUSTERED ([Id] ASC)
);









