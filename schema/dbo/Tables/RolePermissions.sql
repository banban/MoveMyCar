CREATE TABLE [dbo].[RolePermissions] (
    [RoleName]     NVARCHAR (128) CONSTRAINT [DF_RolePermissions_RoleName] DEFAULT ('') NOT NULL,
    [PermissionId] NVARCHAR (322) CONSTRAINT [DF_RolePermissions_PermissionId] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED ([RoleName] ASC, [PermissionId] ASC)
);

