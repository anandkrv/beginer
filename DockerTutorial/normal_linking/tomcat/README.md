For tomcat setup
1.) Build tomcat image
  - docker build -t tomcat7 .
1.) Run tomcat from the built image
  - docker run -it -p 8080:8080 --name tomcat7 --rm tomcat7
2.) Verify if the container running tomcat
  - docker inspect tomcat7 | grep IP
  - curl  172.17.42.1:8080
