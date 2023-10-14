echo -e "\e[32mInstall Golang Package\e[0m"
dnf install golang -y &>>/tmp/roboshop.log

echo -e "\e[32mCreate User to run Application\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app

echo -e "\e[32mDownload Application content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mExtract the Application Code\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app


echo -e "\e[32mInstall Dependencies\e[0m"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
cd

echo -e "\e[32mCopying dispatch service file\e[0m"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[32mTell Systemd to load service content\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mStart dispatch service\e[0m"
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log