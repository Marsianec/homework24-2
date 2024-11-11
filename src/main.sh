#/bin/bash
cat << EOF | sudo tee /var/www/html/index.html 
<html>
  <body>

   <h1>Hi, this is server $HOSTNAME </h1>

   <img src="https://storage.yandexcloud.net/terteryan/123.jpg"/>

  </body>
</html> 
EOF