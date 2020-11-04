package com.training.aws.email.notification;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties
public class EmailNotificationApplication {

  public static void main(String[] args) {
    SpringApplication.run(EmailNotificationApplication.class, args);
  }
}
