echo -e "\e[32mDisable SQL Server version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[32mCopying repo file\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling MySQl community server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[32mStart mysql services\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log

echo -e "\e[32mChange the default Root Password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[32mCheck Password working or not\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log