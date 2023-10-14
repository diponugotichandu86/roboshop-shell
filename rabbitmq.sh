echo -e "\e[32mConfigure YUM Repos from the script provided by vendor\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[32mConfigure YUM Repos for RabbitMQ\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[32mInstall RabbitMQ\e[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log

echo -e "\e[32mStart RabbitMQ Service\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl start rabbitmq-server  &>>/tmp/roboshop.log

echo -e "\e[32mCreate one user for the application\e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log

echo -e "\e[32mGive Permission to Application User\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log