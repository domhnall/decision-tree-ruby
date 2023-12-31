class TreeNode
  attr_reader :column_index,
    :value,
    :true_branch,
    :false_branch,
    :results

  def initialize(
    column_index: nil,
    value: nil,
    true_branch: nil,
    false_branch: nil,
    results: nil)
    @column_index = column_index
    @value = value
    @true_branch = true_branch
    @false_branch = false_branch
    @results = results
  end

  def print(depth = 0)
    if results
      print_with_indent(summary_results, depth*2)
    else
      print_with_indent("(column: #{column_index}, value: #{value})", depth*2)
      print_with_indent("true:", (depth+1)*2)
      true_branch.print(depth+2)
      print_with_indent("false:", (depth+1)*2)
      false_branch.print(depth+2)
    end
  end

  def classify(row)
    classify_prob(row).max_by{ |_,v| v }[0]
  end

  def classify_prob(row)
    return summary_results if results
    if value.is_a?(Numeric)
      if row[column_index] >= value
        true_branch.classify_prob(row)
      else
        false_branch.classify_prob(row)
      end
    elsif row[column_index] == value
      true_branch.classify_prob(row)
    else
      false_branch.classify_prob(row)
    end
  end

  def store(filename)
    File.open(filename, 'wb') do |f|
      f.write(Marshal.dump(self))
    end
  end

  private

  def print_with_indent(output, indent)
    case output
    when String
      puts [" " * indent, output].join('')
    when Array
      output.each{ |item| print_with_indent(item, indent) }
    else
      print_with_indent(output.to_s, indent)
    end
  end

  def summary_results
    results.group_by(&:last).reduce({}) do |memo, (key, value)|
      (memo[key] = value.size) && memo
    end
  end
end
