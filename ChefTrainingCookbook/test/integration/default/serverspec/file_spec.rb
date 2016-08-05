require 'spec_helper'

describe "Checking the my.cnf" do
  describe file('/etc/my.cnf') do
    it { should be_file }
  end
end

describe "Checking the Spring3HibernateApp.war" do
  describe file('/var/lib/tomcat/webapps/Spring3HibernateApp.war') do
    it { should be_file }
  end
end

describe "Checking the nginx.conf" do  

  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
  end
end
