require 'spec_helper_acceptance'

describe 'redis class' do

  context 'install/configure' do
    if fact('osfamily') == 'RedHat'
      it 'adds epel' do
        pp = "class { 'epel': }"
        apply_manifest(pp, :catch_failures => true)
      end
    end

    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'redis': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe port(6379) do
      it { should be_listening.with('tcp') }
    end

  end

end
