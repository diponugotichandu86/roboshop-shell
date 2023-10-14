echo -e "\e[32mInstalling MongoDB Server\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[32mUpdate MongoDB Listen Address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[32mStarting MongoDB Service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log