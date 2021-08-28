/* Example of how to Join a Table Twice */
SELECT 
	A.CommonWellName  AS 'Well', 
	S.PhaseName AS 'Start Phase',
	L.PhaseName AS 'Last Phase Completed'
FROM 
	Wells As A
JOIN WDXTracker AS M ON A.WellID = M.WellID
JOIN WDXTrackerPhaseMaster AS S ON M.StartPhaseID=S.PhaseID
JOIN WDXTrackerPhaseMaster AS L ON M.LastPhaseIDCompleted=L.PhaseID

SELECT
	A.CommonWellName  AS 'Well',
	M.StartPhaseID AS 'Start Phase ID',
	M.LastPhaseIDCompleted AS 'Last Phase Completed ID'
FROM 
	Wells As A
JOIN WDXTracker AS M ON A.WellID = M.WellID