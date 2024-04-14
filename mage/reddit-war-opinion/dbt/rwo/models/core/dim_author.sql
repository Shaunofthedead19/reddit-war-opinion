{{ config(materialized="table") }}

with author as (
    select distinct
        author_name,
        user_is_verified,
        user_account_created_datetime,
        user_total_karma
    from {{ ref("stg_war_comments") }}
)
select {{ dbt_utils.generate_surrogate_key(["author_name"]) }} as author_id,
    author_name,
    user_is_verified,
    user_account_created_datetime,
    user_total_karma
from author