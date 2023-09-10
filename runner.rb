require './decision_tree_trainer'
require './data'
require './mushroom_data'
require 'byebug'

train_rows, test_rows = MushroomData.get_train_and_test_data(max_rows: 2000)
tree = DecisionTreeTrainer.train(train_rows)
tree.store("mushroom_tree.dump")
tree.print
correct_count = test_rows.reduce(0) do |count, row|
  count+=1 if tree.classify(row) == row[-1]
  count
end
puts "Accuracy: #{correct_count/test_rows.size.to_f}"
