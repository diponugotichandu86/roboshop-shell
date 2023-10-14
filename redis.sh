echo -e "\e[32mInstalling Redis Repo File\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[32mEnable redis latest version\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[32mInstalling Redis\e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[32mUpdate the Redis Listen Address\e[0m"
sed -i "s/127.0.0.1/0.0.0.0" /etc/redis.conf

echo -e "\e[32mStart Redis Service\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log