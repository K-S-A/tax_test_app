RSpec.describe FileExport do
  subject { Class.new { include FileExport }.new }

  context '#export_to' do
    it 'should write self.to_s into file' do
      allow(subject).to receive(:to_s).and_return('FileExport')

      expect(File).to receive(:write).with('export/cart.csv', 'FileExport')
      subject.export_to('cart.csv')
    end
  end
end
