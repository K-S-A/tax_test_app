RSpec.describe Cart do
  let(:cart_items) do
    data_from_file('product_params')[0..2].map do |h|
      CartItem.new(Product.new(h['name'], h['base_price']))
    end
  end

  let(:cart) { described_class.new(*cart_items) }

  context '.new' do
    it 'can be initialized witout arguments' do
      expect { described_class.new }.not_to raise_error
    end

    it 'should raise ArgumentError unless all arguments respond to #tax, #price and #to_s' do
      expect { described_class.new(name: 'book') }.to raise_error(ArgumentError, /Expected all arguments to respond/)
    end
  end

  context '#total' do
    it 'should return Float' do
      expect(cart.total).to be_kind_of(Float)
    end

    include_examples 'correct value for', :total, data_from_file('product_params')[0..2], 29.83
    include_examples 'correct value for', :total, data_from_file('product_params')[3..4], 65.15
    include_examples 'correct value for', :total, data_from_file('product_params')[5..8], 74.68

    context 'for empty cart' do
      it 'should return 0.0' do
        expect(described_class.new.total).to eq(0.0)
      end
    end
  end

  context '#tax' do
    it 'should return Float' do
      expect(cart.tax).to be_kind_of(Float)
    end

    include_examples 'correct value for', :tax, data_from_file('product_params')[0..2], 1.50
    include_examples 'correct value for', :tax, data_from_file('product_params')[3..4], 7.65
    include_examples 'correct value for', :tax, data_from_file('product_params')[5..8], 6.70

    context 'for empty cart' do
      it 'should return 0.0' do
        expect(described_class.new.tax).to eq(0.0)
      end
    end
  end

  context '#to_s' do
    it 'should return string with cart items info, cart total and tax' do
      expect(cart.to_s).to eq("1, book, 12.49\n"\
                              "1, music cd, 16.49\n"\
                              "1, chocolate bar, 0.85\n\n"\
                              "Sales Taxes: 1.5\n"\
                              'Total: 29.83')
    end
  end

  context '#items' do
    it 'should return Array' do
      expect(cart.items).to be_kind_of(Array)
    end

    it 'should return array of cart items' do
      expect(cart.items).to eq(cart_items)
    end

    context 'for empty cart' do
      it 'should return empty Array' do
        expect(described_class.new.items).to eq([])
      end
    end
  end
end
