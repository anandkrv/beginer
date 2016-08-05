require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "file hello.txt status" do
  it "file hello.txt" do
    expect(file("/data/hello.txt")).to exist
  end
end
