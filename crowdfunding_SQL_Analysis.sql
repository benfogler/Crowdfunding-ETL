-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT  cf_id, Sum(backers_count) as sum_backers
FROM campaign
WHERE outcome = 'live'
GROUP by cf_id
ORDER by sum_backers DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT  cf_id, COUNT(first_name) as count_backers
FROM backers
GROUP by cf_id
ORDER by count_backers DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT  co.first_name, 
		co.last_name,
		co.email,
		(ca.goal - ca.pledged) as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as co
JOIN campaign as ca
ON co.contact_id = ca.contact_id
WHERE ca.outcome = 'live'
ORDER by "Remaining Goal Amount" DESC;



-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT  
ba.email,
ba.first_name, 
ba.last_name,
ba.cf_id,
ca.company_name,
ca.description,
ca.end_date, 
(ca.goal - ca.pledged) as "Left of Goal"

INTO email_backers_remaining_goal_amount

FROM backers as ba
JOIN campaign as ca
	ON ca.cf_id = ba.cf_id
WHERE ca.outcome = 'live'
ORDER by ba.last_name, ba.email;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;
