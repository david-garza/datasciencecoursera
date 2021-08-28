/* Pulls AFE and Final Well Cost for offshore wells. Dates are set by the ending of the job.
Job Type only Drilling and Completion. Any other job type is not reported.
David C. Garza 01/31/2018 */

USE wv101CalcUnitsUS

DECLARE	@startdate AS DATE
DECLARE @enddate AS DATE
SET @startdate  = '2017-01-01'
SET @enddate = '2017-12-31'

SELECT WVWELLHEADER.DISTRICT, WVJOB.jobtyp AS 'Job Type', WVWELLHEADER.WELLNAME AS 'Well Name', WVJOB.DTTMEND AS 'Job End Date' ,WVJOB.AFEAMTCALC AS 'AFE', WVJOB.AFETOTALCALC AS 'AFE + Supplement', WVJOB.COSTTOTALCALC AS 'Final Cost' 
FROM WVWELLHEADER 
JOIN WVJOB ON WVWELLHEADER.IDWELL = WVJOB.IDWELL 
WHERE 
	WVJOB.DTTMEND >= @startdate 
	AND WVJOB.AFEAMTCALC IS NOT NULL
	AND WVJOB.DTTMEND < @enddate
	AND WVWELLHEADER.LOCATIONTYP = 'Offshore'
	AND (WVJOB.JOBTYP = 'Drilling' OR WVJOB.JOBTYP = 'Completion')
	AND WVWELLHEADER.OPERATOR = 'Hess Corporation'
 ORDER BY WVWELLHEADER.DISTRICT, WVJOB.JOBTYP DESC