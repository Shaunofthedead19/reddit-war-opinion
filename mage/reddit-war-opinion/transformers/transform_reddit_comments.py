if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    
    print('Total missing values: ', data.isna().sum().sum())
    #print(data[data['post_self_text'].isna() == False].shape)
    #print([column for column in list(data.columns) if((data[column].isna().sum()/len(data))*100 < 5.0)])
    dropable  = [column for column in list(data.columns) if((data[column].isna().sum()/len(data))*100 < 5.0)]
    print(dropable)
    cleaned_data = data.dropna(subset=dropable).dropna(axis=1)
    print(cleaned_data.isna().sum().sum())
    print(cleaned_data.shape)
    print(cleaned_data.dtypes)


    return cleaned_data

@test
def test_output(output, *args):
    assert output.isna().sum().sum() == 0, 'There are null values in dataset'