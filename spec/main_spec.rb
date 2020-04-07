require './bin/main'

RSpec.describe 'Enumerable' do
  let(:numbers) {[1, 2, 3, 4]}
  let(:numbers_nil) {[1, 2, 3, 4, nil]}

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
end