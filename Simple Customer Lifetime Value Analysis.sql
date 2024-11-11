
SELECT ROUND(SUM(purchase_revenue_in_usd)/COUNT(*),2) as Average_Order_Value,
      ROUND(COUNT(*)/ COUNT (DISTINCT user_pseudo_id),2) as Purchase_Frequency,
      ROUND(ROUND(SUM(purchase_revenue_in_usd)/COUNT(*),2) * (ROUND(COUNT(*)/ COUNT (DISTINCT user_pseudo_id),2)),2) as Customer_Value,
      --assuming a customer lifespan of 3 years, since the data provides cv for three months
      -- we can get an equivalent for three years = (36/3 = 12months)
      ROUND(12 * ROUND((SUM(purchase_revenue_in_usd)/COUNT(*)) * (COUNT(*)/ COUNT (DISTINCT user_pseudo_id)),2),2) as Customer_Lifetime_Value
FROM `turing_data_analytics.raw_events`
WHERE event_name = 'purchase'


