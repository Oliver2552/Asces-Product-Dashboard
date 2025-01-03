WITH cte AS (	
	-- Going to join product_data and product_sales to get an aggregated table going, in addition to adding calculated columns for revenue and total cost. 
	-- In addition, will format the Date to extract the month and year for analysis later.
	SELECT
		pd.Product,
		pd.Category,
		pd.Brand,
		pd.Description,
		pd.cost_price,
		pd.sale_price,
		pd.Image_url,
		ps.Date,
		ps.Country,
		ps.Customer_Type,
		ps.Discount_Band,
		ps.Units_Sold,
		(sale_price*Units_Sold) AS revenue,
		(cost_price*Units_Sold) AS total_cost,
		FORMAT(date, 'MMMM') AS month,
		FORMAT(date, 'yyyy') AS year
	FROM
		product_data pd
	JOIN
		product_sales ps
	ON
		pd.Product_ID = ps.Product)


SELECT
	*,
	(1 - discount*1.0/100) * revenue AS discounted_revenue -- calculating the revenue, considering the discount.
FROM
	cte a
JOIN
	discount_data dd
ON
	a.Discount_Band = dd.Discount_Band and a.month = dd.Month;