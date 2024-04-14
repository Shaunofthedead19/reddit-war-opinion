{{ config(materialized="table") }}

with subreddits as (
    select distinct subreddit from {{ ref("stg_war_comments") }}
)
select
    {{ dbt_utils.generate_surrogate_key(["subreddit"]) }} as subreddit_id,
    subreddit
from subreddits