use bankloan_DB;

select count(*) from finance_1;
select count(*) from finance_2;

select * from finance_1;
select * from finance_2;

/*
 -1 Year wise loan amount 
 -2 Grade-subgrade wise revolution balance 
 -3 Total Payment for verified status vs non verified status 
 -4 state wise last credit pull _d wise loan status 
 -5 Home ownership vs last payment data stats
 */

#1
SELECT 
    YEAR(issue_date) AS year_issue_date,
    SUM(loan_amnt) AS total_loan_amount
FROM 
    finance_1
GROUP BY 
    YEAR_issue_date
ORDER BY 
    YEAR_issue_date;

#2
SELECT 
    grade, 
    sub_grade, 
    SUM(revol_bal) AS total_revol_bal
FROM 
    finance_1 
JOIN 
    finance_2 ON (finance_1.id = finance_2.id)
GROUP BY 
    grade, 
    sub_grade
ORDER BY 
    grade, 
    sub_grade;

#3
SELECT verification_status,
    concat("$",format (ROUND(SUM(total_pymnt)/1000000,2),2),"M") AS total_payment
FROM 
    finance_1 
JOIN 
    finance_2  ON (finance_1.id = finance_2.id)
GROUP BY 
    verification_status
ORDER BY 
    verification_status;
    
#4
SELECT 
    addr_state,
    last_credit_pull_d,
	loan_status
FROM 
    finance_1 
JOIN 
    finance_2 ON (finance_1.id = finance_2.id)
GROUP BY 
    addr_state,
    last_credit_pull_d,
	loan_status
ORDER BY
    last_credit_pull_d;
    
#5
SELECT 
home_ownership,
last_pymnt_d,
 concat("$", format(ROUND(SUM(last_pymnt_amnt) / 10000,2),2),'K') AS total_amount
 from 
 finance_1
 inner join
 finance_2 on finance_1.id = finance_2.id
 group by 
    home_ownership,
	last_pymnt_d
 order by
    last_pymnt_d desc, 
    home_ownership desc;
    
    
  
    