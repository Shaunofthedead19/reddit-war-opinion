{{ config(materialized="table") }}

with war_comments as (
    SELECT
        -- identifiers
        cast(comment_id as string) as comment_id,    
        cast(post_id as string) as post_id,    
        cast(author_name as string) as author_name,

        -- timestamps
        cast(comment_created_datetime as timestamp) as comment_created_datetime,
        cast(user_account_created_datetime as timestamp) as user_account_created_datetime,
        cast(post_created_datetime as timestamp) as post_created_datetime,

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
        cast(comment as string) as comment,
        cast(controversiality as boolean) as controversiality,
        cast(ups as integer) as ups,
        cast(downs as integer) as downs,

        -- subreddit information    
        cast(subreddit as string) as subreddit
    FROM {{ ref("stg_war_comments") }}
)

SELECT
    wc.comment_id,
    p.post_id,
    a.author_id,
    a.author_name,
    a.user_account_created_datetime,
    a.user_is_verified,
    a.user_total_karma,
    p.post_created_datetime,
    p.post_score,
    p.post_title,
    p.post_self_text,
    p.post_upvote_ratio,
    p.post_thumbs_ups,
    p.post_total_awards_received,
    wc.score,
    wc.comment,
    wc.controversiality,
    wc.ups,
    wc.downs,
    sr.subreddit,
    sr.subreddit_id
FROM war_comments wc
LEFT JOIN {{ ref("dim_author") }} a ON wc.author_name = a.author_name
LEFT JOIN {{ ref("dim_post") }} p ON wc.post_id = p.post_id
LEFT JOIN {{ ref("dim_subreddits") }} sr on wc.subreddit = sr.subreddit