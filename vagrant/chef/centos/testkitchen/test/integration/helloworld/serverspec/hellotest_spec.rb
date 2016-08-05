require 'serverspec'

# Required by serverspec

set :backend, :exec

#describe file('/data/hello.txt') do
#  it { should exist }
#end

describe "file hello.txt status" do
  it "has a file hello.txt" do
    expect(file("/data/hello.txt")).to exist
  end
end
