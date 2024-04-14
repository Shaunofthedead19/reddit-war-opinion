{{ config(materialized="table") }}

with post as (
    select distinct
        post_id,
        post_self_text,
        post_title,
        post_score,
        post_upvote_ratio,
        post_thumbs_ups,
        post_created_datetime,
        post_total_awards_received
    from {{ ref("stg_war_comments") }}
)
select *
from post