module Enumerable # :nodoc:
  # frozen_string_literal: true
  # Returns each item individually

  def my_each
    to_enum(:my_each) unless block_given?
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  # Returns item + index in array
  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  # Returns items that pass the test
  def my_select
    to_enum(:my_select) unless block_given?

    result = []
    my_each { |item| result << item if yield(item) }
    result
  end

  # Returns true or false. All items must meet condition
  def my_all?(*arg)
    result = true
    if !arg[0].nil?
      my_each { |i| result = false unless arg[0] === i } # rubocop:disable Style/CaseEquality
    elsif !block_given?
      my_each { |i| result = false unless i }
    else
      my_each { |i| result = false unless yield(i) }
    end
    result
  end

  # Returns true or false. At least one item must meet condition
  def my_any?(*arg)
    result = false
    if !arg[0].nil?
      my_each { |i| result = true if arg[0] === i } # rubocop:disable Style/CaseEquality
    elsif !block_given?
      my_each { |item| result = true if item }
    else
      my_each { |item| result = true if yield(item) }
    end
    result
  end

  # Returns true or false. At least one item must meet condition
  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  # Returns true or false. At least one item must meet condition
  def my_count(elem = nil)
    counter = 0

    if block_given?
      my_each { |item| counter += 1 if yield(item) }
    elsif elem
      my_each { |item| counter += 1 if item == elem }
    else
      counter = size
    end
    counter
  end

  # Returns a new array with the results of changes to each item
  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    result = []
    if proc.nil?
      my_each { |item| result << yield(item) }
    else
      my_each { |item| result << proc.call(item) }
    end
    result
  end

  # Returns the cumulative results of the operation using all items
  # A starting value is provided as argument
  def my_inject(*arg)
    my_each { |i| arg[0] = yield(arg[0], i) }
  end
end

# Method created to test my_inject by passing array as argument when called
def multiply_els(arr)
  p arr.my_inject(1) { |r, i| r * i }
end
