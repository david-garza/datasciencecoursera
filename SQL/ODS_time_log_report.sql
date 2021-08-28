/* David Garza 11/27/2019
 A time log query to pull all time logs out since 2012. This is intented to be loaded into spotfire.*/

SELECT HEAD.WELLNAME AS 'Well Name', TIMELOG.DTTMSTARTCALC AS 'Start Date and Time', TIMELOG.OPSCATEGORY AS 'OPS Category',TIMELOG.UNSCHEDTYP AS 'NPT Code', JOB.jobtyp AS 'Job Type', TIMELOG.CODE1 AS 'Phase Code', TIMELOG.CODE2 AS 'Activity Code',TIMELOG.DURATION AS 'Duration'
FROM wellview_wv101calcunitsus.WVWELLHEADER AS HEAD
JOIN wellview_wv101calcunitsus.WVJOB AS JOB ON HEAD.IDWELL = JOB.IDWELL 
JOIN wellview_wv101calcunitsus.WVJOBREPORT AS JOBREPORT ON JOBREPORT.IDRECPARENT = JOB.IDREC
JOIN wellview_wv101calcunitsus.WVJOBREPORTTIMELOG AS TIMELOG ON JOBREPORT.IDREC = TIMELOG.IDRECPARENT

WHERE 
	TIMELOG.DTTMSTARTCALC >= '2012-01-01'
	AND HEAD.OPERATOR = 'Hess Corporation'