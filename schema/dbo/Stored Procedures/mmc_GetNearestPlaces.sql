/*=============================================
Author:		Andrew Butenko
Create date: 8/5/2013
Description:	find the nearest places in zone
Example: 
	exec dbo.mmc_GetNearestPlaces @Longitude = 138, @Latitude = -35, @MaxDistance = 100000
	select * from Places 
	update p set IsShared=1 from Places p where Id = 3
	-35.167081111983120	138.504176544982900

	exec [dbo].[mmc_GetNearestPlaces] @UserName=N'TestUser', --@Date=default,
		@Longitude=138,@Latitude=-35
		,@MaxDistance=100000,@MaxCount=100
		--,@MaxPrice=$0.0000,@MaxHours=0,@MaxMinutes=0
=============================================*/
CREATE PROCEDURE [dbo].[mmc_GetNearestPlaces] 
(
	@UserName nvarchar(256) = null --if user is not authenticated show shared places only
	,@Date DateTime = null
	,@Longitude decimal(22,15)
	,@Latitude decimal(22,15)
	,@MaxDistance int = 1000 --meters 
	,@MaxCount smallint = 100 
	,@MaxPrice money = 0
	,@MaxHours tinyint = 2
	,@MaxMinutes tinyint = 0
	,@Occupied bit = null
)
AS
BEGIN
	SET NOCOUNT ON;
	SET DATEFIRST 1;
	IF @Date IS NULL
		SET @Date = GETDATE()

	DECLARE @CurrentLocation geography, @WeekBitMask int
	SELECT @CurrentLocation = geography::STPointFromText('POINT('+convert(varchar(20),nullif(@Longitude,0))+' '+convert(varchar(20),nullif(@Latitude,0))+')', 4326)
		, @WeekBitMask = (CASE DATEPART(WEEKDAY, @Date) WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 3 THEN 4 WHEN 4 THEN 8 WHEN 5 THEN 16 WHEN 6 THEN 32 WHEN 7 THEN 64 END)

	;WITH L1 AS(
		SELECT 
			p.Id, p.Longitude, p.Latitude
			--,geography::STPointFromText('POINT('+convert(varchar(20),nullif(p.Longitude,0))+' '+convert(varchar(20),nullif(p.Latitude,0))+')', 4326) as GeoLocation	
			,MIN(rr.Hours * 60 + rr.Minutes) as MinMinutes
			,MIN(rr.Price) as MinPrice
		FROM dbo.Places p
		LEFT OUTER JOIN dbo.PlacesRestrictions pr 
			INNER JOIN dbo.Restrictions r ON pr.Restriction_PlaceRestriction = r.Id
			INNER JOIN dbo.RestrictionRegulations rr ON rr.Restriction_RestrictionRegulation = r.Id
				AND COALESCE(NULLIF(@MaxPrice,0), rr.Price, 0) <= ISNULL(rr.Price,0)
				AND COALESCE(NULLIF(@MaxHours,0), rr.Hours, 0) + COALESCE(NULLIF(@MaxMinutes,0), rr.Minutes, 0) <= ISNULL(rr.Hours,0) * 60 + ISNULL(rr.Minutes,0)
				AND (@WeekBitMask & rr.WeekBitMask) = @WeekBitMask
		ON p.Id = pr.Place_PlaceRestriction
		WHERE (p.UserName = @UserName OR p.IsShared=1)
		GROUP BY p.Id, p.Longitude, p.Latitude
	)
	, L2 AS(
		SELECT 
			p.Id
			,geography::STPointFromText('POINT('+convert(varchar(20),nullif(p.Longitude,0))+' '+convert(varchar(20),nullif(p.Latitude,0))+')', 4326) as GeoLocation	
			,p.MinMinutes
			,p.MinPrice
		FROM L1 p
	), L3 AS(
		SELECT p.Id, max(m.DateTo) AS OccupiedTo
		FROM dbo.Movements m
		INNER JoiN L1 p ON m.Place_Movement = p.Id
		GROUP BY p.Id 
		HAVING @Date BETWEEN MAX(m.DateTo) AND MAX(m.DateTo)--the place is occupied that moment
	)
	SELECT TOP (@MaxCount) 
		L2.Id
		,Round((@CurrentLocation.STDistance(L2.GeoLocation)) * 1.0/1.852,0) as Distance
		,L2.MinMinutes
		,L2.MinPrice
		,L3.OccupiedTo
	FROM L2
	LEFT OUTER JOIN L3 ON L3.Id = L2.Id
	WHERE Round((@CurrentLocation.STDistance(L2.GeoLocation)) * 1.0/1.852,0) <= @MaxDistance
	--,ROUND((cms2.Geolocation.STDistance(h.GeoLocation.EnvelopeCenter())/1000.0) * 1.0/1.852,2) as [COMPETITOR_RESELLER_SITE_DISTANCE]
	--	, ws.GeoLocation.Lat as StationLatitude
	--, ws.GeoLocation.Long as StationLongitude
	--ON h.GeoLocation.STIntersects(sa.GeoLocation)=1 --h.ShapeID = sa.ID*/
		AND (
			(@Occupied = 1 AND L3.OccupiedTo IS NOT NULL)
			OR (@Occupied = 0 AND L3.OccupiedTo IS NULL)
			OR (@Occupied IS NULL) --any
		)
	ORDER BY 2
END