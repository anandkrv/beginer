# To build ansible image 
docker build --rm  -t opstree/ansible-box .

# To run a container
docker run -it opstree/ansible-box  /bin/bash

#To get the IP of newly launched ansible container
docker ps
docker inspect | grep IPAdd

#Do ssh login to ansbible container
ssh root@<container ip>
