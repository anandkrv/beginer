require 'spec_helper'

describe 'maven' do

  context 'with package_ensure => 3.1.1' do
    let(:params) do {
      :package_ensure => '3.1.1'
    } end
    it { should compile }
    it {
      should contain_exec('install_maven_from_tar_gz').with(
        :command  => "wget -O - http://www.bizdirusa.com/mirrors/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz | tar zxf -"
      )
    }
  end

  context 'with package => my-maven-package' do
    let(:params) do {
      :install_from_package => true,
      :package              => 'my-maven-package'
    } end
    it { should compile }
    it {
      should_not contain_exec('install_maven_from_tar_gz')
      should contain_package('my-maven-package').with(
        :ensure => 'present'
      )
    }
  end

  context 'with package => [my-maven-package1, my-maven-package2]' do
    let(:params) do {
      :install_from_package => true,
      :package              => [
        'my-maven-package1',
        'my-maven-package2'
        ]
    } end
    it { should compile }
    it {
      should_not contain_exec('install_maven_from_tar_gz')
      should contain_package('my-maven-package1')
      should contain_package('my-maven-package2')
    }
  end

end
