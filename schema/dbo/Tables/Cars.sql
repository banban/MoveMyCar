CREATE TABLE [dbo].[Cars] (
    [Id]       INT             IDENTITY (1, 1) NOT NULL,
    [PlateNo]  NVARCHAR (255)  CONSTRAINT [DF_Cars_PlateNo] DEFAULT ('') NOT NULL,
    [Image]    VARBINARY (MAX) NULL,
    [UserName] NVARCHAR (256)  NULL,
    [Color]    VARCHAR (50)    NULL,
    [Model]    VARCHAR (50)    NULL,
    CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED ([Id] ASC)
);





