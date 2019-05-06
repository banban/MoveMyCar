
CREATE VIEW [dbo].[SwapCars]
AS
SELECT        Id, nullif(PlateNo,'') as PlateNo, Image, nullif(UserName,'') as UserName, nullif(Color,'') as Color, nullif(Model,'') as Model
FROM            dbo.Cars