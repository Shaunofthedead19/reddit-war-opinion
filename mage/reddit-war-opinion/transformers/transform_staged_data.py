if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    data.columns = (data.columns
                    .str.replace(' ', '_')
                    .str.lower()
    )

    print('unique subreddits: ', data['subreddit'].nunique(dropna=True))
    print('empty subreddits: ' ,data['subreddit'].isna().sum())
    print('post_score: ', isinstance(data['post_score'], int))
    print('is controversiality int?: ', isinstance(data['controversiality'], int))
    print('is user_is_verified bool?
    : ', isinstance(data['user_is_verified'], bool))
    print('describe controversiality: ', data['controversiality'].describe())
    print('describe user_is_verified: ', data['user_is_verified'].describe())
    print('no. of unique authors: ', data['author_name'].nunique(dropna=True))
    print(data.dtypes)

    return data
