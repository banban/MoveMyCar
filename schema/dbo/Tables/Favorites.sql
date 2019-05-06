CREATE TABLE [dbo].[Favorites] (
    [Id]             INT IDENTITY (1, 1) NOT NULL,
    [Car_Favorite]   INT NOT NULL,
    [Place_Favorite] INT NOT NULL,
    [IsSubscribed]   BIT NULL,
    CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Favorites_Cars] FOREIGN KEY ([Car_Favorite]) REFERENCES [dbo].[Cars] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Favorites_Places] FOREIGN KEY ([Place_Favorite]) REFERENCES [dbo].[Places] ([Id]) ON DELETE CASCADE
);





