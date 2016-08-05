require 'serverspec'

# Required by serverspec

set :backend, :exec

describe "Nginx Server" do

  it "is listening on port 80" do
    expect(port(80)).to be_listening
  end

  it "has a running service of nginx" do
    expect(service("nginx")).to be_running
  end

end
