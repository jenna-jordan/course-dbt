# Week 1 Questions

1. How many users do we have?

```
SELECT distinct count(user_id) 
FROM dbt_jenna_j.stg_users;
```
130

2. On average, how many orders do we receive per hour?

```
WITH orders_per_hour AS (
SELECT count(distinct order_id), date_trunc('hour', created_at) 
FROM dbt_jenna_j.stg_orders 
GROUP BY date_trunc('hour', created_at) )

SELECT round(avg(count), 2) 
FROM orders_per_hour;
```
7.52

3. On average, how long does an order take from being placed to being delivered?

```
WITH delivery_lag_times AS (
SELECT order_id, (delivered_at - created_at) as time_to_deliver
FROM dbt_jenna_j.stg_orders 
WHERE delivered_at IS NOT NULL )

SELECT avg(time_to_deliver) as avg_delivery_lag 
FROM delivery_lag_times;

```
3 days 21:24:11.803279

4. How many users have only made one purchase? Two purchases? Three+ purchases?
- Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

```
WITH single_purchase AS(
SELECT user_id, count(order_id)
FROM dbt_jenna_j.stg_orders 
GROUP BY user_id
HAVING count(order_id) = 1) # or = 2, or >= 3

SELECT count(user_id)
FROM single_purchase;
```
1 purchase: 25
2 purchases: 28
3+ purchases: 71


5. On average, how many unique sessions do we have per hour?

```
WITH sessions_per_hour AS (
SELECT count(distinct session_id), date_trunc('hour', created_at) 
FROM dbt_jenna_j.stg_events 
GROUP BY date_trunc('hour', created_at) )

SELECT round(avg(count), 2) 
FROM sessions_per_hour;
```
16.33