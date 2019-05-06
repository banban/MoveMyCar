CREATE TABLE [dbo].[RestrictionRegulations] (
    [Id]                                INT      IDENTITY (1, 1) NOT NULL,
    [Restriction_RestrictionRegulation] INT      NOT NULL,
    [Hours]                             SMALLINT NULL,
    [Minutes]                           SMALLINT NULL,
    [Price]                             MONEY    NULL,
    [Monday]                            BIT      NULL,
    [Tuesday]                           BIT      NULL,
    [Wednesday]                         BIT      NULL,
    [Thursday]                          BIT      NULL,
    [Friday]                            BIT      NULL,
    [Saturday]                          BIT      NULL,
    [Sunday]                            BIT      NULL,
    [DateFrom]                          DATE     NULL,
    [DateTo]                            DATE     NULL,
    [WeekBitMask]                       AS       (CONVERT([smallint],(((((case [Monday] when (1) then (1) else (0) end+case [Tuesday] when (1) then (2) else (0) end)+case [Wednesday] when (1) then (4) else (0) end)+case [Thursday] when (1) then (8) else (0) end)+case [Friday] when (1) then (16) else (0) end)+case [Saturday] when (1) then (32) else (0) end)+case [Sunday] when (1) then (64) else (0) end,(0))),
    CONSTRAINT [PK_RestrictionRegulations] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_RestrictionRegulations_Restrictions] FOREIGN KEY ([Restriction_RestrictionRegulation]) REFERENCES [dbo].[Restrictions] ([Id])
);



