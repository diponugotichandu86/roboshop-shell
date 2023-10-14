echo -e "\e[32mInstalling MongoDB Server\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y  -y &>>/tmp/roboshop.log
#Modify the config file
echo -e "\e[32mStarting MongoDB Service\e[0m"
systemctl enable mongod -y &>>/tmp/roboshop.log
systemctl restart mongod -y &>>/tmp/roboshop.log