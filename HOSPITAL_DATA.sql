		--> **** HOSPITAL DATABASE **** <--
	
	--> **** CREATING TABLE FOR HOSPITAL **** <--
CREATE TABLE HOSPITALS(
	Hospital_Name VARCHAR (100),
	Locations VARCHAR (100),
	Department VARCHAR (50),
	Doctors_Count INT , 
	Patient_Count INT , 
	Admission_Date DATE,
	Discharge_Date DATE,
	Medical_Expensess NUMERIC (10,2)
	);

SELECT * FROM HOSPITALS;

		--> **** QUESTION AND ANSWER **** <-

/* Q1} TOTAL NUMBER OF PATIENTS.
   Write an SQL query to find the total number 
   of patients across all hospitals. */

		--> **** ANSWER **** <--
SELECT SUM (Patient_Count) AS TOTAL_NUMBER_OF_PATIENT
FROM HOSPITALS;
--> {9347}

		--> **** EXTRA **** <--

	--> **** TOP 10 HOSPITALS BY MAXIMUM PATIENT COUNT **** <--

SELECT Hospital_Name , Locations , Department, Patient_Count
FROM HOSPITALS
ORDER BY Patient_Count DESC
LIMIT 10;

	--> **** TOP 10 HOSPITALS BY MINIMUM PATIENT COUNT **** <--

SELECT Hospital_Name , Locations , Department, Patient_Count
FROM HOSPITALS
ORDER BY Patient_Count ASC
LIMIT 10;

/* Q2} AVERAGE NUMBER OF DOCTORS PER HOSPITAL. 	
   Retrieve the average count of doctors available
   in each hospital. */

			--> **** ANSWER **** <--
SELECT ROUND(AVG(Doctors_Count),
2) AS AVERAGE_NUMBER_OF_DOCTOR_IN_HOSPITAL
FROM HOSPITALS;
--> 26.71 AVE. NUM. OF DOCTORS IN HOSPITALS.

		--> **** EXTRA **** <--
	
	--> **** MAXIMUM NUMBER OF DOCTORS **** <--

SELECT Hospital_Name, Department, Locations, 
MAX(Doctors_Count) AS MAXIMUM_NUMBER_OF_DOCTORS
FROM HOSPITALS
GROUP BY Hospital_Name, Department, Locations
ORDER BY MAXIMUM_NUMBER_OF_DOCTORS DESC
LIMIT 1;
--> 49 MAX. NUM. OF DOCTORS IN HOSPITALS.

	--> **** MINIMUM NUMBER OF DOCTORS **** <--
	
SELECT Hospital_Name, Department, Locations, 
MIN(Doctors_Count) AS MINIMUM_NUMBER_OF_DOCTORS
FROM HOSPITALS
GROUP BY Hospital_Name, Department, Locations
ORDER BY MINIMUM_NUMBER_OF_DOCTORS ASC
LIMIT 1;
--> 5 MIN. NUM. OF DOCTORS IN HOSPITALS.


	--> **** NUMBERS OF DOCTORS **** <--

SELECT 
ROUND(AVG(Doctors_Count), 2) AS AVERAGE_NUMBER_OF_DOCTORS
FROM HOSPITALS;
--> 2671 TOTAL DOCTORS IN HOSPITALS


/* Q3} TOP 3 DEPARTMENTS WITH THE HIGHEST NUMBER OF PATIENTS 
	Find the top 3 hospital departments that have the
	highest number of patients. */

		--> **** ANSWER **** <--

SELECT  Department, Patient_Count
FROM HOSPITALS
ORDER BY Patient_Count DESC
LIMIT 3;

		--> **** EXTRA **** <--

	--> **** MINIMUM NUMBER OF PATIENTS **** <--
 
SELECT Hospital_Name , Locations, Department, Patient_Count 
FROM HOSPITALS
ORDER BY Patient_Count ASC
LIMIT 3;

	--> **** MAXIMUM NUMBER OF PATIENTS **** <--

SELECT Hospital_Name, Locations, Department, Patient_Count 
FROM HOSPITALS
ORDER BY Patient_Count DESC
LIMIT 3;

	--> **** MINIIMUM NUMBER OF DOCTORS **** <--

SELECT Hospital_Name, Locations, Department, Doctors_Count
FROM HOSPITALS
ORDER BY Doctors_Count ASC
LIMIT 3;

/* Q4} HOSPITAL WITH THE MAXIMUM MEDICAL EXPENSES. 	
	   Identify the hospital that recorded the highest medical expenses. */
		
		--> **** ANSWER **** <--
		
	--> **** MAXIMUM MEDICAL EXPENSES **** <--
SELECT Hospital_Name, Locations, Department, Medical_Expensess
FROM HOSPITALS
ORDER BY Medical_Expensess DESC
LIMIT 1;

		--> **** EXTRA **** <--
	--> **** MINIMUM MEDICAL EXPENSES **** <--
SELECT Hospital_Name, Locations, Department, Medical_Expensess
FROM HOSPITALS
ORDER BY Medical_Expensess ASC
LIMIT 1;

/* Q5} DAILY AVERAGE MEDICAL EXPENSESS. 
	   Calculate the average medical expenses per 
	   day for each hospital. */
	
		--> **** ANSWER **** <--

SELECT Hospital_Name,  
ROUND(AVG(Medical_Expensess) / NULLIF(AVG(Discharge_Date - Admission_Date), 
0), 2) AS DAILY_AVERAGE_OF_MEDICAL_EXPENSESS
FROM HOSPITALS
GROUP BY Hospital_Name
ORDER BY Hospital_Name ASC;

		--> ****  ASCENDING ORDER **** <--
SELECT Hospital_Name,  
ROUND(AVG(Medical_Expensess) / NULLIF(AVG(Discharge_Date - Admission_Date), 
0), 2) AS DAILY_AVERAGE_OF_MEDICAL_EXPENSESS
FROM HOSPITALS
GROUP BY Hospital_Name
ORDER BY DAILY_AVERAGE_OF_MEDICAL_EXPENSESS DESC;

		/* DAILY AVERAGE OF MEDICAL EXPENSESS 
		PER HOSPITAL, DEPARTMENT & LOCATIONS.*/

		--> ****  DESCENDING ORDER **** <--
SELECT Hospital_Name, Locations, Department,
ROUND(AVG(Medical_Expensess) / NULLIF(AVG(Discharge_Date - Admission_Date),
0), 2) AS AVERAGE_PER_DAY_MEDICAL_EXPENSES
FROM HOSPITALS
GROUP BY Hospital_Name,Locations,Department
ORDER BY AVERAGE_PER_DAY_MEDICAL_EXPENSES DESC
LIMIT 10;

		--> ****  ASCENDING ORDER **** <--
SELECT Hospital_Name, Locations, Department,
ROUND(AVG(Medical_Expensess) / NULLIF(AVG(Discharge_Date - Admission_Date), 
0), 2) AS AVERAGE_PER_DAY_MEDICAL_EXPENSES
FROM HOSPITALS
GROUP BY Hospital_Name,Locations,Department
ORDER BY AVERAGE_PER_DAY_MEDICAL_EXPENSES ASC
LIMIT 10;

/* Q6} LONGEST HOSPITAL STAY.
	Find the patient with the longest stay by 
	calculating the difference between Discharge 
	Date and Admission Date. */ 

		--> **** ANSWER **** <--
		
	--> ****  MAXIMUM DURATION OF HOSPITAL STAY **** <--
SELECT Hospital_Name, Locations , Patient_Count, 
Admission_Date, Discharge_Date,
(Discharge_Date - Admission_Date) AS LENGTH_OF_STAY
FROM HOSPITALS
ORDER BY LENGTH_OF_STAY DESC
LIMIT 1;

		--> **** EXTRA **** <--
	--> ****  MINIMUM DURATION OF HOSPITAL STAY **** <--
SELECT Hospital_Name, Locations , Patient_Count, 
Admission_Date, Discharge_Date,
(Discharge_Date - Admission_Date) AS LENGTH_OF_STAY
FROM HOSPITALS
ORDER BY LENGTH_OF_STAY ASC
LIMIT 1;

		/* MINIMUM , MAXIMUM AND AVERAGE 
		DURATION OF HOSPITAL STAY.*/

SELECT Hospital_Name,
MIN(Discharge_Date - Admission_Date) AS MIN_LENGTH_OF_STAY,
MAX(Discharge_Date - Admission_Date) AS MAX_LENGTH_OF_STAY,
ROUND(AVG(Discharge_Date - Admission_Date), 2) AS AVG_LENGTH_OF_STAY
FROM HOSPITALS
GROUP BY Hospital_Name
ORDER BY  Hospital_Name ASC;


/* Q7} TOTAL PATIENTS TREATED PER CITY  
	Count the total number of patients treated in each city.*/

		--> **** ANSWER **** <--
SELECT Locations AS CITY,
SUM(Patient_Count) AS NUMBER_OF_PATIENTS_TREATED
FROM HOSPITALS
GROUP BY Locations
ORDER BY Locations ASC;

		--> **** EXTRA **** <--
	/* COUNT , MAXIMUM , MINIMUM , TOTAL & AVERAGE OF  
	NUMBER OF HOSPITAL TREATMENT STATISTICS BY LOCATIONS .*/
	
SELECT Locations AS CITY,
COUNT(Patient_Count) AS COUNT_OF_PATIENTS,
MAX(Patient_Count) AS MAX_NUM_OF_PATIENTS,
MIN(Patient_Count) AS MIN_NUM_OF_PATIENTS,
SUM(Patient_Count) AS TOTAL_NUM_OF_PATIENTS,
ROUND(AVG(Patient_Count), 2) AS AVG_NUM_OF_PATIENTS
FROM HOSPITALS
GROUP BY Locations
ORDER BY Locations ASC;

	/* COUNT , MAXIMUM , MINIMUM , TOTAL & AVERAGE OF  
	NUMBER OF HOSPITAL TREATMENT STATISTICS BY .*/

SELECT Hospital_Name,
COUNT(Patient_Count) AS COUNT_OF_PATIENTS,
MAX(Patient_Count) AS MAX_NUM_OF_PATIENTS,
MIN(Patient_Count) AS MIN_NUM_OF_PATIENTS,
SUM(Patient_Count) AS TOTAL_NUM_OF_PATIENTS,
ROUND(AVG(Patient_Count), 2) AS AVG_NUM_OF_PATIENTS
FROM HOSPITALS
GROUP BY Hospital_Name
ORDER BY Hospital_Name ASC;


/* Q8} AVERAGE LENGTH OF STAY PER DEPARTMENT  
		Calculate the average number of days patients
		spend in each department. */

		--> **** ANSWER **** <--
SELECT Department, 
ROUND(AVG(Discharge_Date - Admission_Date), 
2) AS AVERAGE_LENGTH_OF_STAY
FROM HOSPITALS
GROUP BY Department
ORDER BY Department DESC;

		--> ****  ASCENDING ORDER **** <--

SELECT Department, 
ROUND(AVG(Discharge_Date - Admission_Date), 
2) AS AVERAGE_LENGTH_OF_STAY
FROM HOSPITALS
GROUP BY Department
ORDER BY Department ASC;

		--> **** EXTRA **** <--
	/* COUNT , MAXIMUM , MINIMUM , TOTAL & AVERAGE 
	LENGTH OF STAY PATIENTS IN EACH DEPARTMENT. */		
SELECT Department,
COUNT(*) AS TOTAL_PATIENTS,
MAX(Discharge_Date - Admission_Date) AS MAX_LENGTH_OF_STAY,
MIN(Discharge_Date - Admission_Date) AS MIN_LENGTH_OF_STAY,
ROUND(AVG(Discharge_Date - Admission_Date), 2) AS AVG_LENGTH_OF_STAY
FROM HOSPITALS
GROUP BY Department
ORDER BY MAX_LENGTH_OF_STAY DESC;


/* Q9} IDENTIFY THE DEPARTMENT WITH THE LOWEST NUMBER OF PATIENTS
	Find the department with the least number of patients. */

		--> **** ANSWER **** <--
SELECT Department, 
MIN(Patient_Count) AS Total_Patients
FROM HOSPITALS
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;

		--> **** EXTRA **** <--
		
		/* MAXIMUM NUMBER OF PATIENT 
			IN PER DEPARTMENT. */	
	
SELECT Hospital_Name, Locations, Department, Medical_Expensess,
COUNT(*) AS TOTAL_COUNT,
MAX(Patient_Count) AS MAX_PATIENTS ,
MIN(Patient_Count) AS MIN_PATIENTS,
ROUND(AVG(Patient_Count), 2) AS AVG_PATIENTS
FROM HOSPITALS
GROUP BY Hospital_Name, Locations, Department , Medical_Expensess
ORDER BY MAX_PATIENTS DESC
LIMIT 10;

		/* MINIMUM NUMBER OF PATIENT 
			IN PER DEPARTMENT. */	

SELECT Hospital_Name, Locations, Department, Medical_Expensess,
COUNT(*) AS TOTAL_COUNT, 
MAX(Patient_Count) AS MAX_PATIENTS,
MIN(Patient_Count) AS MIN_PATIENTS,
ROUND(AVG(Patient_Count), 2) AS AVG_PATIENTS
FROM HOSPITALS
GROUP BY Hospital_Name, Locations, Department, Medical_Expensess
ORDER BY MIN_PATIENTS ASC
LIMIT 10;

/* Q10} MONTHLY MEDICAL EXPENSES REPORT 
	Group the data by month and calculate the 
	total medical expenses for each month. */

		--> **** ANSWER **** <--

SELECT TO_CHAR(Admission_Date, 'MONTH') AS YEAR_2023, 
SUM(Medical_Expensess) AS TOTAL_MEDICAL_EXPENSES
FROM HOSPITALS
GROUP BY TO_CHAR(Admission_Date, 'MONTH'),
EXTRACT(MONTH FROM Admission_Date)
ORDER BY EXTRACT(MONTH FROM Admission_Date) ASC;

		--> **** EXTRA **** <--
		
		/* MINIMUM, MAXIMUM, AVERAGE & TOTAL
		MEDICAL EXPENSES BY MONTH. */
			
SELECT TO_CHAR(Admission_Date, 'MONTH') AS YEAR_2023, 
		MIN(Medical_Expensess) AS MINIMUM_MEDICAL_EXPENSES,
		MAX(Medical_Expensess) AS MAXIMUM_EXPENSES,
		ROUND(AVG(Medical_Expensess), 2) AS AVERAGE_EXPENSES,
		SUM(Medical_Expensess) AS TOTAL_MEDICAL_EXPENSES
FROM HOSPITALS
GROUP BY TO_CHAR(Admission_Date, 'MONTH'),
EXTRACT(MONTH FROM Admission_Date)
ORDER BY EXTRACT(MONTH FROM Admission_Date) ASC;

			/* REPLACE THE LOCATIONS_NAME
			TO FILTER THE RESULTS */

SELECT Hospital_Name,Locations, Department,
       TO_CHAR(Admission_Date, 'MONTH') AS MONTH_NAME, 
       ROUND(MIN(Medical_Expensess), 2) AS MIN_EXP,
       ROUND(MAX(Medical_Expensess), 2) AS MAX_EXP,
       ROUND(AVG(Medical_Expensess), 2) AS AVE_EXP
	  
FROM HOSPITALS

WHERE Locations  = 'Pune'  /* {" CHANGE THE LOCATION TO VIEW DATA BY LOCATION " } */
			/* {'Ahmedabad', 'Bangalore', 'Chennai','Delhi', 'Hyderabad',
			'Jaipur', 'Kolkata', 'Lucknow', 'Mumbai', 'Pune'} */

GROUP BY Hospital_Name, Locations, Department, MONTH_NAME,
EXTRACT(MONTH FROM Admission_Date)
ORDER BY EXTRACT(MONTH FROM Admission_Date);


			/* REPLACE THE MONTH_NAME
			TO FILTER THE RESULTS */

SELECT Hospital_Name,Locations, Department,
       TO_CHAR(Admission_Date, 'MONTH') AS MONTH_NAME, 
       ROUND(MAX(Medical_Expensess), 2) AS MAX_EXP,
       ROUND(MIN(Medical_Expensess), 2) AS MIN_EXP,
       ROUND(AVG(Medical_Expensess), 2) AS AVG_EXP,
	   SUM(Medical_Expensess) AS TOTAL_EXPENSESS
FROM HOSPITALS
WHERE TRIM(TO_CHAR(Admission_Date, 'Month')) = 'October'
/* {" CHANGE THE MONTH HERE TO VIEW MONTHLY DATA " } */
					/* {'January', 'February', 'March', April'  
					   'May', 'June','July' , 'August', 
					   'September','October', 'November', 'December'} */ 
GROUP BY Hospital_Name, Locations, Department, MONTH_NAME,
EXTRACT(MONTH FROM Admission_Date)
ORDER BY EXTRACT(MONTH FROM Admission_Date);


			/* REPLACE THE DEPARTMENT_NAME
			TO FILTER THE RESULTS */

SELECT Hospital_Name, Locations, Department,
       TO_CHAR(Admission_Date, 'MONTH') AS MONTH_NAME, 
       ROUND(MAX(Medical_Expensess), 2) AS MAX_EXP,
       ROUND(MIN(Medical_Expensess), 2) AS MIN_EXP,
       ROUND(AVG(Medical_Expensess), 2) AS AVG_EXP,
	   SUM(Medical_Expensess) AS TOTAL_EXPENSESS
FROM HOSPITALS
WHERE Department = 'ENT'
             /*{"REPLACE THE DEPARTMENT NAME ABOVE TO FILTER THE RESULTS."} 
			   { DEPARTMENT_NAME <--> 'Cardiology', 'Dermatology', 
			   'ENT','General Medicine','Gynecology','Neurology',
			   'Oncology','Orthopedics','Pediatrics','Urology' }*/

GROUP BY Hospital_Name, Locations, Department, 
         TO_CHAR(Admission_Date, 'MONTH'),
         EXTRACT(MONTH FROM Admission_Date)
ORDER BY Hospital_Name;


	/* REPLACE THE HOSPITAL_NAME
			TO FILTER THE RESULTS */
--> **** REPLACE THE HOSPITAL_NAME TO FILTER THE RESULTS **** <--

SELECT Hospital_Name, Locations, Department,
       TO_CHAR(Admission_Date, 'MONTH') AS MONTH_NAME, 
       ROUND(MAX(Medical_Expensess), 2) AS MAX_EXP,
       ROUND(MIN(Medical_Expensess), 2) AS MIN_EXP,
       ROUND(AVG(Medical_Expensess), 2) AS AVG_EXP,
	   SUM(Medical_Expensess) AS TOTAL_EXPENSESS
FROM HOSPITALS
WHERE Hospital_Name  = 'Apollo Health'
	 /*{ "REPLACE THE HOSPITAL_NAME ABOVE TO FILTER THE RESULTS." } 
	    HOSPITAL_NAME <--> 'Apollo Health', 'City Hospital', 'Fortis Care',
	   'Global Medicare', 'Green Valley Hospital', 'Healing Touch', 'Heritage Hospital', 
	   'Metro Hospital', 'Sunrise Medical', 'Wellness Clinic'.*/

GROUP BY Hospital_Name, Locations, Department, 
TO_CHAR(Admission_Date, 'MONTH'),
EXTRACT(MONTH FROM Admission_Date)
ORDER BY Locations;

		--> **** DONE **** <--

	--> **** DROP THE TABLE IF YOU WANT **** <--
DROP TABLE IF EXISTS HOSPITALS;

		--> ****<->**** <--












































