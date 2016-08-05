require 'spec_helper_acceptance'

describe 'memcached class' do
  let(:manifest) {
    <<-EOS
      class { 'memcached': }
    EOS
  }

  describe 'running puppet code' do
    it 'should work with no errors' do
      # Run it twice and test for idempotency
      apply_manifest(manifest, :catch_failures => true)
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
    end

  end

  describe 'command line tools' do
    it 'memcached -h should work' do
      expect(shell("memcached -h").exit_code).to eql(0)
    end
  end
end
