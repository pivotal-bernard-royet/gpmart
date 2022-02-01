-- Noncorrelated subquery
-- Requests female and male customers with the maximum 
-- annual income from customers

SELECT customer_name, annual_income
FROM public.customer_dimension
WHERE (customer_gender, annual_income) IN
      (SELECT customer_gender, MAX(annual_income)
       FROM public.customer_dimension
       GROUP BY customer_gender);
