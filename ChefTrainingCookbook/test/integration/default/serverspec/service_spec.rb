require 'spec_helper'

describe "MysqlDB Daemon" do
  it "has a running service of mysqld" do
    expect(service("mysqld")).to be_running
  end
end

#describe "Tomcat Daemon" do
#  it "has a running service of tomcat" do
#    expect(service("tomcat")).to be_running
#  end
#end

describe "Nginx Daemon" do
  it "has a running service of nginx" do
    expect(service("nginx")).to be_running
  end
end
