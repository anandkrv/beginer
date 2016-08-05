1.) Create an image from docker public nginx image
  - docker build -t nginx-proxy .
2.) Run the container from this image
  - docker run --name nginx-proxy --link tomcat7:tomcat -d nginx-proxy
3.) Verify if it ran fine
  - docker inspect nginx-proxy | grep IP
  - curl  <ip of nginx-proxy container>
4.) Docker file is also updating the default.conf by doing a proxy entry of tomcat using tomcat hostname(--link tomcat7:tomcat) as we are using docker linking
