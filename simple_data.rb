module SimpleData
  DATA = [
    ['slashdot', 'USA', 'yes', 18, 'None'],
    ['google', 'France', 'yes', 23, 'Premium'],
    ['digg', 'USA', 'yes', 24, 'Basic'],
    ['kiwitobes', 'France', 'yes', 23, 'Basic'],
    ['google', 'UK', 'no', 21, 'Premium'],
    ['(direct)', 'New Zealand', 'no', 12, 'None'],
    ['(direct)', 'UK', 'no', 21, 'Basic'],
    ['google', 'USA', 'no', 24, 'Premium'],
    ['slashdot', 'France', 'yes', 19, 'None'],
    ['digg', 'USA', 'no', 18, 'None'],
    ['google', 'UK', 'no', 18, 'None'],
    ['kiwitobes', 'UK', 'no', 19, 'None'],
    ['digg', 'New Zealand', 'yes', 12, 'Basic'],
    ['slashdot', 'UK', 'no', 21, 'None'],
    ['google', 'UK', 'no', 18, 'Basic'],
    ['kiwitobes', 'France', 'yes', 19, 'Basic']
  ]

  def self.get_train_and_test_data(split: 0.1)
    train_data = DATA.dup
    # Let's remove :split of data for testing
    full_size = train_data.size
    test_data =(0..(full_size*split)).to_a.map do |i|
      train_data.delete_at(rand(full_size-i))
    end

    [train_data, test_data]
  end
end
