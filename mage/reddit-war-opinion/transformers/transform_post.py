if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    post = data[['post_id', 'post_title', 'post_score', 'post_upvote_ratio', 'post_thumbs_ups', 'post_created_time', 'post_total_awards_received', 'subreddit']]
    temp_initial_shape = post.shape
    print('post: ',temp_initial_shape)
    post.drop_duplicates(subset=['post_id', 'post_created_time', 'subreddit'], keep='first', ignore_index=True, inplace=True)
    temp_new_shape = post.shape
    print('post: ', temp_new_shape)

    return post