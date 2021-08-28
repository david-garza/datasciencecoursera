/* Query to measure the length of WDX Phases */
USE WDX_PROD

-- Scope times
SELECT 
	Wells.CommonWellName AS 'Well Name', 
	Wells.JobType AS 'Job Type',
	Wells.JobNumber AS 'Job Number',
	WDXTrackerLineItems.MilestoneActivity AS 'Meeting', 
	WDXTrackerLineItems.PlannedDate AS 'Planned Date',
	WDXTrackerLineItems.ActualDate AS 'Actual Date'
 FROM Wells 
	JOIN WDXTrackerLineItems ON Wells.WellID = WDXTrackerLineItems.WellID
 WHERE 
 (WDXTrackerLineItems.MilestoneActivity = 'Scope Kickoff Meeting' OR WDXTrackerLineItems.MilestoneActivity = 'Scope to Design Approval')

 -- Design Times
 SELECT 
	Wells.CommonWellName AS 'Well Name', 
	Wells.JobType AS 'Job Type',
	Wells.JobNumber AS 'Job Number',
	WDXTrackerLineItems.MilestoneActivity AS 'Meeting', 
	WDXTrackerLineItems.PlannedDate AS 'Planned Date',
	WDXTrackerLineItems.ActualDate AS 'Actual Date'
 FROM Wells 
	JOIN WDXTrackerLineItems ON Wells.WellID = WDXTrackerLineItems.WellID
 WHERE 
 (WDXTrackerLineItems.MilestoneActivity = 'Design Phase Kickoff Meeting' OR WDXTrackerLineItems.MilestoneActivity = 'Design to Plan Approval')

 -- Plan Times
 SELECT 
	Wells.CommonWellName AS 'Well Name', 
	Wells.JobType AS 'Job Type',
	Wells.JobNumber AS 'Job Number',
	WDXTrackerLineItems.MilestoneActivity AS 'Meeting', 
	WDXTrackerLineItems.PlannedDate AS 'Planned Date',
	WDXTrackerLineItems.ActualDate AS 'Actual Date'
 FROM Wells 
	JOIN WDXTrackerLineItems ON Wells.WellID = WDXTrackerLineItems.WellID
 WHERE 
 (WDXTrackerLineItems.MilestoneActivity = 'Planning Kickoff Meeting' OR WDXTrackerLineItems.MilestoneActivity = 'Planning to Operate Approval')