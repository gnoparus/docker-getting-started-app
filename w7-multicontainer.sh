docker network create todo-app

docker run -d \
    --network todo-app --network-alias mysql \
    -v todo-mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=todos \
    -e MYSQL_ROOT_HOST=% \
    mysql:8.0

docker exec -it <mysql-container-id> mysql -u root -p

CREATE USER 'todouser'@'%' IDENTIFIED BY 'todopassword123';
GRANT ALL ON *.* TO 'todouser'@'%';    


docker run -dp 127.0.0.1:3000:3000 \
  -w /app -v "$(pwd):/app" \
  --network todo-app \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=todouser \
  -e MYSQL_PASSWORD=todopassword123 \
  -e MYSQL_DB=todos \
  node:18-alpine \
  sh -c "yarn install && yarn run dev"

