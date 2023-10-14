echo -e "\e[32mInstall Paython Package\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[32mCreate User to run Application\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mCreate Directory to keep Application\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32mDownload the application Code\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mExtract the Application code\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mInstall Dependencies\e[0m"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
cd

echo -e "\e[32mCopying payment service file\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[32mTell Systemd to load modified content\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mStart payment Service\e[0m"
systemctl enable payment  &>>/tmp/roboshop.log
systemctl start payment &>>/tmp/roboshop.log