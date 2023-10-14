echo -e "\e[32mInstalling Maven, so it it will auto Install Java\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[32mAdding Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreate Directory to keep Application\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32mInstalling Shipping related Content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mUnzip the Content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mDownload the dependencies & build the application\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar
cd

echo -e "\e[32mCopying Shipping Service file\e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[32mTell the Systemd to reload the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mInstalling mysqlclient to load the schema\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[32mLoad the schema\e[0m"
mysql -h mysql-dev.devops86.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[32mStart shipping Service\e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log