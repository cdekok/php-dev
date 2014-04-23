PHP Development container
=======

This container is meant as php development container
websites can be added in /www/{project}.web.dev and accessed under the same domain in your browser

```
sudo apt-get install dnsmasq
echo "address=/.web.dev/127.0.0.1" > /etc/dnsmasq.d/web.dev
docker build -t chris/php-dev .
docker run -i -t -h php -p 80:80 -p 22 -v /www:/var/www --name php chris/php-dev
```
Now you can add your website on:
/www/{project}.web.dev/public/index.php
