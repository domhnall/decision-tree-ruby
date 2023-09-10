require 'csv'
require 'byebug'

raw_data = CSV.read('mushroom/agaricus-lepiota.data')
classifications = []
raw_data.each{|row| classifications << row.delete_at(0) }
MUSHROOM_TRAIN_DATA = raw_data.zip(classifications)

# Let's remove 10% of data for testing
full_size = MUSHROOM_TRAIN_DATA.size
(full_size/10).times do |i|
  MUSHROOM_TEST_DATA = MUSHROOM_TRAIN_DATA.delete_at(rand(full_size-i))
end
