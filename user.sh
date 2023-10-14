echo -e "\e[32mSetting up NodeJS repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32mInstalling NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32mAdding Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreating Directory for Application\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[32mDownload the NodeJS Content\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mExtract the Content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mInstall NodeJS Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[32mCopying catalogue service file to desired location\e[0m"
cd
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[32mTell the Systemd to reload the service content and start the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

echo -e "\e[32mCopying mongodb repo file\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling mongodb-client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[32mLoad the schema\e[0m"
mongo --host mongodb-dev.devops86.store </app/schema/user.js &>>/tmp/roboshop.log