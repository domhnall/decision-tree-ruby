require './decision_tree_trainer'
require './data'
require './mushroom_data'
require 'byebug'

#trainer = DecisionTreeTrainer.new(DATA)
#rows = ["a"]*5 + ["b"]*5
#rows = rows.map{ |el| Array(el) }
#trainer.send(:entropy, rows)
tree = DecisionTreeTrainer.train(DATA)

#tree = DecisionTreeTrainer.train(MUSHROOM_TRAIN_DATA)
#tree.print
#MUSHROOM_TEST_DATA.each do |row|
#  puts tree.classify(row)
#end

puts tree.classify(['digg', 'New Zealand', 'yes', 12, 'Basic'])
