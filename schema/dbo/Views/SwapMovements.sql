

--select * from [dbo].[SwapMovements]
CREATE VIEW [dbo].[SwapMovements]
AS
SELECT        Id, nullif(DateFrom, '19000101') as DateFrom, nullif(Hours,0) as Hours, nullif(Minutes,0) as Minutes, nullif(Amount,0) as Amount, nullif(DateTo,'19000101') as DateTo, nullif(Description,'') Description
	, nullif(Car_Movement,0) as Car_Movement, nullif(Place_Movement,0) as Place_Movement
	, nullif(Swap_Movement,0) as Swap_Movement, nullif(SwapCar_Movement,0) as SwapCar_Movement, SwapStatus
FROM dbo.Movements
WHERE SwapStatus>0