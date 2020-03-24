# rubocop:disable Style/CaseEquality

module Enumerable # :nodoc:
    # frozen_string_literal: true
    # Returns each item individually
    def my_each
      i = 0
      while i < length
        yield(i)
        i += 1
      end
    end
  
    # Returns item + index in array
    def my_each_with_index
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
    end
  
    # Returns items that pass the test
    def my_select
      result = []
      my_each do |item|
        result << item if yield(item)
      end
    end
  
    # Returns true or false. All items must meet condition
    def my_all?
      result = true
      my_each do |item|
        result = false unless yield(item)
      end
      result
    end
  
    # Returns true or false. At least one item must meet condition
    def my_any?
      result = false
      my_each { |item| result = true if yield(item) }
      result
    end
  
    
  end