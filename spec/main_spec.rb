require './bin/main'

RSpec.describe 'Enumerable' do
  let(:numbers) {[1, 2, 3, 4]}
  let(:numbers_nil) {[1, 2, 3, 4, nil]}
  let(:array_str){%w[hola 3244 adios valida 344 _er tambien]}

  describe '.my_each' do
    it 'returns each item with an operation applied' do
      result = []
      numbers.my_each { |n| result << n * 2}
      result2 = []
      numbers.each { |n| result2 << n * 2}
      expect(result).to eql(result2)
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each).to be_a(Enumerator)
    end
  end

  describe '.my_each_with_index' do
    it '' do
      result = []
      numbers.my_each_with_index { |n, i| result << "#{n}: #{i}"}
      expect(result).to eql(["1: 0", "2: 1", "3: 2", "4: 3"])
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe '.my_select' do
    it 'returns items that return true to the block' do
      expect(numbers.my_select { |n| n > 2 }).to eql(numbers.select { |n| n > 2 })
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
      it 'will return false if at least one item is nil or false' do
        expect(numbers_nil.my_all?).to be_falsy
      end
      it 'will return true if all the elements are of a given class' do
        expect(numbers.my_all?(Integer)).to eq(true)
      end
      it 'will return false if not all the elements are of a given class' do
        expect(array_str.my_all?(Numeric)).to eq(false)
      end
      it 'will return true if all items match regular expression' do
        expect(numbers.my_all?(/\d/)).to eq(true)
      end
      it 'will return false if not all items match regular expression' do
        expect(numbers_nil.my_all?(/\d/)).to eq(false)
      end
    end
  end

end