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
  

  end