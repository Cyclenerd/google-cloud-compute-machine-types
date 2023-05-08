SELECT
	date() AS date,
	name,
	region,
	ROUND(hour, 4)       AS hour,
	ROUND(hourSpot, 4)   AS hourSpot,
	ROUND(month, 2)      AS month,
	ROUND(month1yCud, 2) AS month1yCud,
	ROUND(month3yCud, 2) AS month3yCud
FROM instances
ORDER BY name, region