with

source as (

    select * from {{  source('staging', 'war_comments') }}

),

renamed as (

    select
        comment_id,
        score,
        self_text,
        subreddit,
        created_time,
        post_id,
        author_name,
        controversiality,
        ups,
        downs,
        user_is_verified,
        user_account_created_time,
        user_awardee_karma,
        user_awarder_karma,
        user_link_karma,
        user_comment_karma,
        user_total_karma,
        post_score,
        post_title,
        post_upvote_ratio,
        post_thumbs_ups,
        post_total_awards_received,
        post_created_time
    
    from source

)

select * from renamed