CREATE TABLE [dbo].[Movements] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [DateFrom]         DATETIME      CONSTRAINT [DF_Movements_DateFrom] DEFAULT (getdate()) NOT NULL,
    [Hours]            SMALLINT      CONSTRAINT [DF_Movements_Hours] DEFAULT ((0)) NULL,
    [Minutes]          SMALLINT      CONSTRAINT [DF_Movements_Minutes] DEFAULT ((0)) NULL,
    [Amount]           MONEY         NULL,
    [DateTo]           DATETIME      NULL,
    [Description]      VARCHAR (255) NULL,
    [Car_Movement]     INT           CONSTRAINT [DF_Movements_Car_Movement] DEFAULT ((0)) NOT NULL,
    [Place_Movement]   INT           NOT NULL,
    [Swap_Movement]    INT           NULL,
    [SwapCar_Movement] INT           NULL,
    [SwapStatus]       SMALLINT      NULL,
    [Rating]           SMALLINT      NULL,
    CONSTRAINT [PK_Movements] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Car_Movement] FOREIGN KEY ([Car_Movement]) REFERENCES [dbo].[Cars] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Movements_Places] FOREIGN KEY ([Place_Movement]) REFERENCES [dbo].[Places] ([Id]) ON DELETE CASCADE
);











