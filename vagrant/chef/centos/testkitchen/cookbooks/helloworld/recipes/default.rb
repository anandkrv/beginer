#
# Cookbook Name:: helloworld
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory '/data' 

file '/data/hello.txt' do
  content 'Hello World'
  mode '0755'
end
