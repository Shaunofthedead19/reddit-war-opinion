import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://www.kaggle.com/datasets/asaniczka/reddit-on-israel-palestine-daily-updated/data?select=reddit_opinion_PSE_ISR.csv'
    
    comment_dtypes = {
        'comment_id': str,
        'score': pd.Int64Dtype(),
        'self_text': str,
        'subreddit': str,
        'post_id': str,
        'author_name': str,
        'controversiality': pd.Int64Dtype(),
        'ups': pd.Int64Dtype(),
        'downs': pd.Int64Dtype(),
        'user_is_verified': bool,
        'user_awardee_karma': pd.Int64Dtype(),
        'user_awarder_karma': pd.Int64Dtype(),
        'user_link_karma': pd.Int64Dtype(),
        'user_comment_karma': pd.Int64Dtype(),
        'user_total_karma': pd.Int64Dtype(),
        'post_score': pd.Int64Dtype(),
        'post_self_text': str,
        'post_title': str,
        'post_upvote_ratio': pd.Int64Dtype(),
        'post_thumbs_ups': pd.Int64Dtype(),
        'post_total_awards_received': pd.Int64Dtype()
    }

    parse_dates = ['created_time','user_account_created_time', 'post_created_time']

    return pd.read_csv(url, dtype= comment_dtypes)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
