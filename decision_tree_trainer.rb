require "./decision_node"

class DecisionTreeTrainer
  def self.train(rows, max_depth: nil)
    self.new(rows, max_depth: max_depth).train
  end

  attr_reader :all_rows, :total_rows, :num_attributes, :root_node, :max_depth
  def initialize(rows, max_depth: 10)
    @all_rows = rows
    @num_attributes = all_rows.first.size - 1 # Never split on last attribute
    @total_rows = all_rows.size
    @root_node = nil
    @max_depth = 10
  end

  # Returns a DecisionNode, which is the root of the tree we have trained
  def train
    return @root_node if @root_node
    puts "Starting training ..."
    start_time = Time.now
    @root_node = build_decision_node(self.all_rows)
    puts "Completed training in #{Time.now - start_time} seconds"
    @root_node
  end

  def build_decision_node(rows, depth = 0)
    max_info_gain = 0
    split_index = -1
    split_value = nil
    initial_entropy = entropy(rows)
    return DecisionNode.new(results: rows) if (initial_entropy == 0 || depth >= max_depth)

    num_attributes.times do |i|
      rows.map{|r| r[i] }.uniq.each do |value|
        new_rows = divide_set(rows, i, value)
        new_entropy = new_rows.reduce(0) do |memo, branch|
          memo+=entropy(branch)*branch.size/rows.size
        end
        info_gain = (initial_entropy - new_entropy)
        if info_gain > max_info_gain
          max_info_gain = info_gain
          split_index = i
          split_value = value
        end
      end
    end

    # OK if we have an info gain, lets split according to best criteria found
    if max_info_gain <= 0
      DecisionNode.new(results: rows)
    else
      true_rows, false_rows = divide_set(rows, split_index, split_value)

      DecisionNode.new(
        column_index: split_index,
        value: split_value,
        true_branch: build_decision_node(true_rows, depth + 1),
        false_branch: build_decision_node(false_rows, depth + 1),
      )
    end
  end

  private

  def entropy(rows)
    rows.group_by(&:last).reduce(0) do |entropy,(key, value)|
      prob = value.length.to_f / rows.size
      entropy -= prob * Math.log(prob, 2)
    end
  end

  def divide_set(rows, column_index, value)
    split_function = if value.is_a? Numeric
      lambda{ |row| row[column_index] >= value }
    else
      lambda{ |row| row[column_index] == value }
    end

    rows.partition(&split_function)
  end
end
