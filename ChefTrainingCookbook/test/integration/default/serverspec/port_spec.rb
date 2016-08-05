require 'spec_helper'

describe "MysqlDB Daemon" do
  it "is listening on port 3306" do
    expect(port(3306)).to be_listening
  end
end

#describe "Tomcat Daemon" do
#  it "is listening on port 8080" do
#    expect(port(8080)).to be_listening
#  end
#end

describe "Nginx Daemon" do
  it "is listening on port 80" do
    expect(port(80)).to be_listening
  end
end
