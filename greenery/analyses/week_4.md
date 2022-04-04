# Week 4 Questions

## Part 1

Snapshot successfully run using the "check" strategy (on "status" column)

## Part 2

Product Funnel Results 

```
select 
  round((sum(level_page_view)*1.0) / count(session_guid),3) as total_sessions,
  round((sum(level_add_to_cart)*1.0) / count(session_guid),3) as cart_sessions,
  round((sum(level_checkout)*1.0) / count(session_guid),3) as checkout_sessions
from dbt_jenna_j.funnel_sessions
```

- total_sessions: 1.000
- cart_sessions: 0.808
- checkout_sessions: 0.625

## Part 3

### 3A. dbt next steps for you

1. if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

One thing we want to do, but have no easy way to do, is to track how our database tables depend on each other, as well as how our dashboards depend on tables. This is something dbt can easily do! (Thanks exposures)

2. if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

We're not currently using dbt

3. if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

The most important thing was learning the current data modeling style/philosophy, and how dbt enables this. Also, getting a strong foundation in the technical aspect of dbt.

### 3B. Setting up for production / scheduled dbt run of your project

1. how would you go about setting up a production/scheduled dbt run of your project in an ideal state? What steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata?

This is honestly the part of dbt that I feel least prepared for and still have the most questions about. It seems like the norm is to run dbt every early morning so that it is ready by the time people start work. Our orchestration tool is Civis, and I need to do more research into how Civis and dbt can best work together. I still need to investigate all of the metadata that dbt's artifacts provide.