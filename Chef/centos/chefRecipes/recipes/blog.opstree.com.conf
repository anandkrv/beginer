server {
    listen       80;
    server_name  blog.opstree.com;

    access_log /var/log/nginx/blog.opstree.com.access.log;
    error_log /var/log/nginx/blog.opstree.com.error.log;
    location / {
        root   /usr/share/nginx/blog;
        index  index.html index.htm;
    }

    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/blog;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/blog;
    }

}
