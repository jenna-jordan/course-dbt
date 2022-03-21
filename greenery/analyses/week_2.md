# Week 2 Questions

## Part 1

We were approached by the marketing team to answer some questions about Greenery’s users! Use your staging models you created in Week 1 to answer their questions:

1. What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased

```
with user_order_counts as (
select u.user_id, 
  count(o.order_id), 
  case when count(o.order_id) > 0 then 1 else 0 end as buyer,
  case when count(o.order_id) > 1 then 1 else 0 end as repeat_buyer
from dbt_jenna_j.stg_users u
left join dbt_jenna_j.stg_orders o on u.user_id = o.user_id
group by u.user_id)

select 
  round(sum(repeat_buyer)::decimal / sum(buyer)::decimal, 4) as rate
from user_order_counts;
```
0.7984

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Indicators of a user likely to purchase again:

- saved payment info to account
- purchased multiple products in their first order
- purchased products that will be "used up"
- left a positive review

Indicators of a users likely to not purchase again:

- left a negative review
- did not save payment information or did not create an account

Features to investigate

- product attributes
- account attributes
- how site was discovered by user
- satisfaction with purchase

3. Explain the marts models you added. Why did you organize the models in the way you did?

I added the suggested models: fact_orders, dim_products, dim_users, user_order_facts, and fact_page_views (I may add more later as time allows). I used the suggested organization. I did not use any intermediate models, and I'm not sure where I might be able to move a CTE into it's own intermediate model (I'm not sure I totally understand the point of intermediate models).

4. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

![](week_2_dag.png)

