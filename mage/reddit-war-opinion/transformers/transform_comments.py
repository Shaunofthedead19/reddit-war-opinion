if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    comments = data[['comment_id', 'created_time', 'self_text', 'score', 'controversiality', 'ups', 'downs', 'post_id', 'author_name']]
    temp_initial_shape = comments.shape
    print('comments: ',temp_initial_shape)
    comments.drop_duplicates(subset=['comment_id', 'created_time', 'post_id', 'author_name'], keep='first', ignore_index=True, inplace=True)
    temp_new_shape = comments.shape
    print('comments: ', temp_new_shape)

    return comments
