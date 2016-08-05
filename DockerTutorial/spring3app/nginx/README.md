1)docker build -t spring/nginx .

2)docker run -it --name proxy-server -p 80:80 --link spring3test:my-tom -d spring/nginx

