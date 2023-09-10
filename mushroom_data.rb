require 'csv'
require 'byebug'

module MushroomData
  def self.get_train_and_test_data(max_rows: 10_000, split: 0.1)
    raw_data = CSV.read('mushroom/agaricus-lepiota.data')[0..max_rows]
    classifications = []
    #train_data = raw_data.each{ |row| row << row.delete_at(0) }
    train_data = raw_data.map{ |row| row[1..3].append(row[0]) }

    # Let's remove :split of data for testing
    full_size = train_data.size
    test_data =(0..(full_size*split)).to_a.map do |i|
      train_data.delete_at(rand(full_size-i))
    end

    [train_data, test_data]
  end
end
