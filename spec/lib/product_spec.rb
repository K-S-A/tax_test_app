RSpec.describe Product do
  let(:product) { described_class.new('book', 12.49) }

  context '.new' do
    it 'should not be initialized witout arguments' do
      expect { described_class.new }.to raise_error(ArgumentError, /given 0, expected 2/)
    end

    it 'should be initialized with two arguments' do
      expect { product }.not_to raise_error
    end

    it 'should raise ArgumentError if first argument is not String' do
      expect { described_class.new(252, 12.49) }.to raise_error(ArgumentError, /Expected String/)
    end

    it 'should raise ArgumentError if second argument is not a number' do
      expect { described_class.new('book', '123') }.to raise_error(ArgumentError, /Expected Float/)
    end

    it 'assigns @name' do
      expect(product.instance_variable_get(:@name)).to eq('book')
    end

    it 'assigns @price' do
      expect(product.instance_variable_get(:@price)).to eq(12.49)
    end
  end

  context '#name' do
    it 'should return name of the product' do
      expect(product.name).to eq('book')
    end
  end

  context '#price' do
    it 'should return base price of the product' do
      expect(product.price).to eq(12.49)
    end
  end
end
