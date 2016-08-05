mysqlpass = data_bag_item("mysql", "rtpass.json")

mysql_service "mysqldefault" do
  initial_root_password mysqlpass["password"]
  action [:create, :start]
end
