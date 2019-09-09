require './lib/counter.rb'

describe GemsCounter do
  subject(:gemfiles) { Counter.new(dir_name) }
  let(:dir_name) { 'gemfiles' }

  describe '.new'
  it 'creates an instance of Counter' do
    expect(gemfiles).to be_an_instance_of(Counter)
  end

  context 'with directory empty' do
    let!(:dir_name) { 'gem_test' }

    it 'raises an ArgumentError' do
      expect { gemfiles }.to raise_error(ArgumentError)
    end
  end

  context 'with no directory' do
    let!(:dir_name) { './spec/fixtures/no_dir'}
    it 'raises an ArgumentError' do
      expect { gemfiles }.to raise_error(ArgumentError)
    end
  end

describe '#fetch_all_gems' do
  subject(:fetch_gems) { gemfiles.fetch_all_gems }
  it 'returns the array of gems with their versions' do
    expect(fetch_gems).to be_an_instance_of(Array)
  end

  it 'checks if all gems have been added' do
    expect(fetch_gems.size).to eq(83)
  end

end

describe '#count_all_gems' do
  it 'returns hash of gems with their occurences' do
    expect(gemfiles.count_all_gems).to be_an_instance_of(Hash)
  end
end

describe '#rails_gems' do
  it 'returns array of rails gems with their versions' do
    expect(gemfiles.rails_gems).to be_an_instance_of(Array)
  end
end

describe '#count_rails_versions' do
  it 'returns hash of rails gems versions with their occurences' do
    expect(gemfiles.count_rails_versions).to be_an_instance_of(Hash)
  end
end

describe '#count_ruby_versions' do
  it 'returns hash of ruby versions with their occurences' do
    expect(gemfiles.count_ruby_versions).to be_an_instance_of(Hash)
  end
end

end