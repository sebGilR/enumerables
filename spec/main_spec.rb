require './bin/main'

RSpec.describe Enumerable do
  let(:numbers) { [1, 2, 3, 4] }
  let(:numbers_nil) { [1, 2, 3, 4, nil] }
  let(:array_str) { %w[hola 3244 adios valida 344 _er tambien] }

  describe '.my_each' do
    it 'returns each item with an operation applied' do
      result = []
      numbers.my_each { |n| result << n * 2 }
      result2 = []
      numbers.each { |n| result2 << n * 2 }
      expect(result).to eql(result2)
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each).to be_a(Enumerator)
    end
  end

  describe '.my_each_with_index' do
    it 'returns each item with its index' do
      result = []
      numbers.my_each_with_index { |n, i| result << "#{n}: #{i}" }
      expect(result).to eql(['1: 0', '2: 1', '3: 2', '4: 3'])
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe '.my_select' do
    it 'returns items that return true to the block' do
      original_output = numbers.select { |n| n > 2 }
      expect(numbers.my_select { |n| n > 2 }).to eql(original_output)
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_select).to be_a(Enumerator)
    end
  end

  describe '.my_all' do
    context 'there is a block given' do
      it 'returns true if all elements in array fits the contition' do
        expect(array_str.my_all? { |i| i =~ /./ }).to eq(true)
      end

      it 'returns false if not all elements in array fits the contition' do
        expect(array_str.my_all? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if all the items are not nil nor false' do
        expect(numbers.my_all?).to be_truthy
      end

      it 'will return false if some items are  nil or false' do
        expect(numbers_nil.my_all?).to be_falsy
      end

      it 'will return true if all the elements are of a given class' do
        expect(numbers.my_all?(Integer)).to eq(true)
      end

      it 'will return false if not all the elements are of a given class' do
        expect(numbers_nil.my_all?(Integer)).to eq(false)
      end

      it 'will return true if all items match regular expression' do
        expect(numbers.my_all?(/\d/)).to eq(true)
      end

      it 'will return false if not all items match regular expression' do
        expect(array_str.my_all?(/\d/)).to eq(false)
      end
    end
  end

  describe '.my_any' do
    context 'there is a block given' do
      it 'returns true if any element in array fits the contition' do
        expect(array_str.my_any? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(true)
      end

      it 'returns false if none of the elements fits the condition' do
        expect(numbers.my_any? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if any the items is truthy' do
        expect(numbers_nil.my_any?).to eql(true)
      end

      it 'will return false if none the items is truthy' do
        expect([nil, false].my_any?).to eql(false)
      end

      it 'will return true if any element is of a given class' do
        expect(['s', 's', 3, 's'].my_any?(Integer)).to eq(true)
      end

      it 'will return false if none element is of a given class' do
        expect(%w[s s 3 s].my_any?(Integer)).to eq(false)
      end

      it 'will return true if any item match regular expression' do
        expect(array_str.my_any?(/\d/)).to eq(true)
      end

      it 'will return false if none item match regular expression' do
        expect(array_str.my_any?(/\+/)).to eq(false)
      end
    end
  end

  describe '.my_none' do
    context 'there is a block given' do
      it 'returns true if none of the elements in array fit the contition' do
        expect(numbers.my_none? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(true)
      end

      it 'returns false if any of the elements fit the condition' do
        expect(array_str.my_none? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if none of the items is truthy' do
        expect([nil, false].my_none?).to eql(true)
      end

      it 'will return false if any of the items is truthy' do
        expect([nil, false, 3, 'hello'].my_none?).to eql(false)
      end

      it 'will return true if none of the element\
          is of a given class' do
        expect(%w[s s 3 s].my_none?(Numeric)).to eq(true)
      end

      it 'will return false if any element is of a given class' do
        expect(numbers_nil.my_none?(Numeric)).to eq(false)
      end

      it 'will return true if none if the items match regular expression' do
        expect(numbers.my_none?(/s/)).to eq(true)
      end

      it 'will return false if any of the items doesn not\
          match regular expression' do
        expect(%w[s s 3 s].my_none?(/s/)).to eq(false)
      end
    end
  end

  describe '.my_count' do
    context 'block_given' do
      it 'returns number of items that meet the condition in the block' do
        original_output = numbers.count { |n| n > 2 }
        expect(numbers.my_count { |n| n > 2 }).to eql(original_output)
      end
    end

    context '!block_given' do
      it 'returns the number of elements that match a passed as argument' do
        expect(numbers.my_count(2)).to eql(numbers.count(2))
      end
    end
  end

  describe '.my_map' do
    it 'returns a new array with the given operation applied to each item' do
      expect(numbers.my_map { |n| n < 3 }).to eq(numbers.map { |n| n < 3 })
    end
    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_map).to be_a(Enumerator)
    end
  end

  describe '.my_inject' do
    context 'only a symbol passed as argument' do
      it 'returns the cumulative result of the operation\
          applied to all the elements' do
        expect((5..10).my_inject(:*)).to eql((5..10).inject(:*))
      end
    end

    context 'symbol and initial value passed as argument' do
      it 'returns acumulation of the operation on all the\
          elements, with initial value' do
        original_output = (5..10).inject(2, :*)
        expect((5..10).my_inject(2, :*)).to eql(original_output)
      end
    end

    context 'only block passed' do
      it 'returns cumulative result of operations on all items' do
        original_output = numbers.inject { |r, i| r * i }
        expect(numbers.my_inject { |r, i| r * i }).to eql(original_output)
      end
    end

    context 'initial value and block passed' do
      it 'returns acumulation of operations on all items, with initial value' do
        original_output = numbers.inject(2) { |r, i| r * i }
        expect(numbers.my_inject(2) { |r, i| r * i }).to eql(original_output)
      end
    end
  end
end
