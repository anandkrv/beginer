sudo chef-apply -l info -e "cron 'tuesdaycron' do
  minute '50'
  hour '11'
  weekday '2'
  command '/bin/true'
  action :create
end"
