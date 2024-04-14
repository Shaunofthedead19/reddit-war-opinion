{{ config(materialized="view") }}

with war_comments as (

    select * from {{  source('staging', 'war_comments') }}

)
select
    -- identifiers
    cast(comment_id as string) as comment_id,    
    cast(post_id as string) as post_id,    
    cast(author_name as string) as author_name,

    -- timestamps
    cast(created_time as timestamp) as comment_created_datetime,
    cast(user_account_created_time as timestamp) as user_account_created_datetime,
    cast(post_created_time as timestamp) as post_created_datetime,

    -- author information
    cast(user_is_verified as boolean) as user_is_verified,
    cast(user_total_karma as integer) as user_total_karma,

    -- post information
    cast(post_score as numeric) as post_score,
    cast(post_title as string) as post_title,
    cast(post_self_text as string) as post_self_text,
    cast(post_upvote_ratio as numeric) as post_upvote_ratio,
    cast(post_thumbs_ups as integer) as post_thumbs_ups,
    cast(post_total_awards_received as integer) as post_total_awards_received,

    -- comment information
    cast(score as integer) as score,
    cast(self_text as string) as comment,
    cast(controversiality as boolean) as controversiality,
    cast(ups as integer) as ups,
    cast(downs as integer) as downs,

    -- subreddit information    
    cast(subreddit as string) as subreddit
from war_comments

-- dbt build --select stg_war_comments.sql --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

    limit 1000

{% endif %}