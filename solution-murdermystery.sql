-- first im searching for any clues in crime scene report
SELECT *
FROM crime_scene_report
WHERE type='murder' AND date='20180115' AND city='SQL City'

-- first witness lives on Northwestern Dr in the last house of the street, so I tried to find them
SELECT TOP 1 *
FROM person
WHERE address_street_name='Northwestern Dr'
ORDER BY address_number DESC

--the second witness's name was Annabel and she lives on Franklin Ave 
SELECT *
FROM person
WHERE address_street_name='Franklin Ave' AND name LIKE '%Annabel%'

--next step was to read the interview transcript of these two people
SELECT p.id, p.name, p.ssn, p.address_street_name, i.transcript
FROM interview i
LEFT JOIN person p
	ON i.person_id = p.id
WHERE p.id = 14887 OR p.id=16371

--from the interview I got info about gym habits of the murderer
SELECT *
FROM get_fit_now_member m
INNER JOIN get_fit_now_check_in c
	ON c.membership_id = m.id
WHERE c.check_in_date ='20180109' AND c.membership_id LIKE '48Z%'


--there were two people seen at the gym that day, so I had to use all the inforamtion to find who it was
SELECT p.ssn, p.id AS 'Person Id', p.name, m.id AS 'Gym Id', m.membership_status, c.check_in_date, d.plate_number
FROM get_fit_now_member m
INNER JOIN get_fit_now_check_in c
	ON c.membership_id = m.id
INNER JOIN person p
	ON m.person_id = p.id
INNER JOIN drivers_license d
	ON p.license_id=d.id
WHERE c.check_in_date ='20180109' AND c.membership_id LIKE '48Z%' AND d.plate_number LIKE '%H42W%'

-- the murderer was person with ssn: 871539279

--then I started the bonus quest 
SELECT *
FROM person p
INNER JOIN drivers_license d
	ON p.license_id = d.id
INNER JOIN facebook_event_checkin f
	ON f.person_id=p.id
WHERE d.car_make='Tesla' AND d.car_model='Model S' AND gender='female' AND f.event_name='SQL Symphony Concert'

--so the person who paid ssn:871539279 to murder someone was ssn: 987756388
              

