WITH registrations AS (
  SELECT user_pseudo_id,
         DATE_TRUNC(MIN(PARSE_DATE('%Y%m%d',event_date)),WEEK) as registration_week
  FROM `turing_data_analytics.raw_events`
  GROUP BY user_pseudo_id
),

revenue AS (
  SELECT user_pseudo_id,
         DATE_TRUNC(PARSE_DATE('%Y%m%d',event_date),WEEK) as revenue_week,
         SUM(purchase_revenue_in_usd) as total_revenue
  FROM `turing_data_analytics.raw_events`
  WHERE event_name = 'purchase'
  GROUP BY 1,2
)

SELECT reg.registration_week,
       COUNT(DISTINCT reg.user_pseudo_id) as total_users,         
       ROUND(SUM(CASE WHEN revenue_week = registration_week THEN rev.total_revenue END)/COUNT(reg.user_pseudo_id),4) as week_0,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 1 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_1,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 2 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_2,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 3 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_3,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 4 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_4,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 5 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_5,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 6 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_6,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 7 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_7,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 8 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_8,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 9 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_9,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 10 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_10,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 11 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_11,
       ROUND(SUM(CASE WHEN revenue_week = DATE_ADD(registration_week,INTERVAL 12 WEEK) THEN rev.total_revenue ELSE 0.0 END)/COUNT(reg.user_pseudo_id),4) as week_12
       
FROM registrations reg
LEFT JOIN revenue rev
ON reg.user_pseudo_id = rev.user_pseudo_id  
WHERE reg.registration_week <= '2021-01-24'     
GROUP BY reg.registration_week
ORDER BY reg.registration_week

       