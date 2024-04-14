if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    
    print('Total missing values: ', data.isna().sum().sum())
    print(data.isna().sum())

    data.dropna(subset=['self_text'], inplace=True)
    miss_values = {"user_is_verified": False, "user_account_created_time": '1900-01-01T00:00:00', "user_total_karma": 0, "post_self_text": 'NA'}
    cleaned_data = data.fillna(value=miss_values)
    cleaned_data.dropna(axis=1, inplace=True)

    print(cleaned_data.isna().sum())

    {{ dbt_utils.generate_surrogate_key(["subreddit"]) }} as subreddit_id,{{ dbt_utils.generate_surrogate_key(["subreddit"]) }} as subreddit_id,return cleaned_data

@test
def test_output(output, *args):
    assert output.isna().sum().sum() == 0, 'There are null values in dataset'