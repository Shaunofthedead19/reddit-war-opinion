if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print(list(data.columns))
    author = data[['author_name', 'user_is_verified', 'user_account_created_time', 'user_total_karma']]
    temp_initial_shape = author.shape
    print('authors: ',temp_initial_shape)
    author.drop_duplicates(subset=['author_name', 'user_account_created_time'], keep='first', ignore_index=True, inplace=True)
    temp_new_shape = author.shape
    print('authors: ', temp_new_shape)

    return author