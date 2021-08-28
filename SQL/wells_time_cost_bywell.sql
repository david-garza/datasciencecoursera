/* Pulls AFE and Final Well Cost and planned duration and actual durations for all jobs globablly. Dates are set by the ending of the job.
Group peforming work is Drilling and Completions.  
David C. Garza 08/28/2019 */

USE wv101Calc

DECLARE @startdate AS DATE
DECLARE @enddate AS DATE
SET @startdate = '2016-01-01' 
SET @enddate = '2017-01-01'

SELECT WVWELLHEADER.DISTRICT AS 'Asset', WVWELLHEADER.WELLNAME AS 'Well Name',WVJOB.jobtyp AS 'Job Type', WVJOB.DTTMEND AS 'End Date',WVJOB.AFEAMTCALC AS 'AFE', WVJOB.AFETOTALCALC AS 'AFE + Supplement', WVJOB.COSTTOTALCALC AS 'Final Cost', sum(WVJOBPROGRAMPHASE.DurationML) AS 'Planned Time', sum(WVJOBPROGRAMPHASE.DurationActualCalc) AS 'Actual Time'
FROM WVWELLHEADER 
JOIN WVJOB ON WVWELLHEADER.IDWELL = WVJOB.IDWELL 
JOIN WVJOBPROGRAMPHASE ON WVJOBPROGRAMPHASE.idrecparent = WVJOB.idrec
 WHERE 
	WVJOB.DTTMEND >= @startdate
	AND WVJOB.DTTMEND < @enddate
	AND WVWELLHEADER.DISTRICT <> 'North Dakota'
	AND WVJOB.AFEAMTCALC IS NOT NULL
	AND (WVJOB.resulttechnical = 'Drilling' OR WVJOB.resulttechnical = 'Completions' OR WVJOB.resulttechnical = 'Drilling & Completions')
	AND WVWELLHEADER.OPERATOR = 'Hess Corporation'
 GROUP BY WVWELLHEADER.DISTRICT, WVJOB.jobtyp, WVWELLHEADER.WELLNAME, WVJOB.AFEAMTCALC, WVJOB.AFETOTALCALC, WVJOB.COSTTOTALCALC, WVJOB.DTTMEND
 ORDER BY WVJOB.JOBTYP DESC, WVJOB.DTTMEND ASC