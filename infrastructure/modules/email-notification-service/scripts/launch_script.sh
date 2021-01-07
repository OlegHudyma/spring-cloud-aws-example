#!/bin/bash
export SPRING_PROFILES_ACTIVE=dev
sudo yum update -y
sudo yum upgrade -y
sudo yum install git -y
sudo yum install java-1.8.0-openjdk -y
sudo yum install maven -y
git clone https://github.com/OlegHudyma/spring-cloud-aws-example.git
cd spring-cloud-aws-example/email-notification-service/
mvn clean package
java -jar target/email-notification-service-0.0.1-SNAPSHOT.jar > /home/ec2-user/log &
sudo yum install awslogs -y
sudo sed -i -e "s/file = \/var\/log\/messages/file=\/home\/ec2-user\/log/" /etc/awslogs/awslogs.conf
sudo sed -i -e "s/log_group_name = \/var\/log\/messages/log_group_name = \/email-notification-service/" /etc/awslogs/awslogs.conf
sudo sed -i -e "s/datetime_format = \%b \%d \%H:\%M:\%S/datetime_format = \%y-\%m-\%d \%a \%H:\%M:\%S/" /etc/awslogs/awslogs.conf
sudo sed -i -e "s/region = us-east-1/region = eu-central-1/" /etc/awslogs/awscli.conf
sudo systemctl restart awslogsd.service


