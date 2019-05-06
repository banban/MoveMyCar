CREATE TABLE [dbo].[PlacesRestrictions] (
    [Id]                           INT IDENTITY (1, 1) NOT NULL,
    [Place_PlaceRestriction]       INT NOT NULL,
    [Restriction_PlaceRestriction] INT NOT NULL,
    CONSTRAINT [PK_PlacesRestrictions] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_PlacesRestrictions_Places] FOREIGN KEY ([Place_PlaceRestriction]) REFERENCES [dbo].[Places] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_PlacesRestrictions_Restrictions] FOREIGN KEY ([Restriction_PlaceRestriction]) REFERENCES [dbo].[Restrictions] ([Id]) ON DELETE CASCADE
);



