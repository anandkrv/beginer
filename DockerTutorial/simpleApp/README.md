Today, we will run a jave application which uses mysql for data storage. Our setup require two containers

a) mysql (database used by our application)

b) tomcat (we will deploy our application here)

We will use image "mysql/mysql-server" for our database container.

Execute the following command:

    docker pull mysql/mysql-server

Once the image is downloaded, check all the available docker images on your machine by:

    docker images

Let's spin the container with a database, issue the following command:

    docker run --name <my-container-name> -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=employeedb -d mysql/mysql-server

In the above command, we have set the password for root user and created database with name employeedb.

As the result of above command, you will get the id running conatiner that we have just launched. 

Now, check if you can login into the the database "employeedb"

    mysql -u root -p -h <IP-of-your-machine/container IP>

 Our database is ready to use. Let us spin tomcat container and deploy our application on it.

 We will use image "tomcat7".

 Run the following command and it will download the image if not present locally:

    docker run -it --name <tomcat-container-name> -p 80:8080 -d tomcat7

Now, copy the application war in the document root of tomcat by following command:

    docker cp /vagrant/Spring3HibernateApp.war <tomcat-container-name>:/usr/local/tomcat/webapps/

Now we have to update the IP of database in our application. So, we will login into the container and make required changes.

    docker exec -it tomcat-container-name bash

Now we are inside our container. Let's update the database.properties file in our application.

    vi webapps/Spring3HibernateApp/WEB-INF/classes/database.properties 

 Update the below line:

    database.url=jdbc:mysql://<IP>/employeedb

 Restart the container as we need to restart the tomcat service.

    docker restart tomcat-container-name


 Kudos!!! You are ready to access the application on browser now.

    http://<IP-of-machine>/Spring3HibernateApp


