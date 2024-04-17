{{ config(materialized="table") }}

with war_comments as (
    select * from {{ ref("fact_comments") }}
)

select
    subreddit,
    -- 'extract' function is specific to BigQuery. The function could vary depending on tye of database for e.g. postgres, bigquery etc.
    extract(month from comment_created_datetime) as month,

    count(distinct post_id) as N_posts,
    count(distinct comment_id) as N_comments,
    count(distinct author_id) as N_authors,

    avg(post_score) as avg_post_score,
    avg(score) as avg_comment_score,
    sum(case when controversiality = True then 1 else 0 end) as N_controversial_comments,
    sum(case when user_is_verified = True then 1 else 0 end) as N_comments_by_verified_users,
    sum(case when user_is_verified = False then 1 else 0 end) as N_comments_by_unverified_users
from war_comments
group by 1,2