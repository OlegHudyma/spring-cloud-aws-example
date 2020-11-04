package com.training.aws.email.notification.config.mail;

import com.amazonaws.services.simpleemail.AmazonSimpleEmailService;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceClientBuilder;
import org.springframework.cloud.aws.mail.simplemail.SimpleEmailServiceJavaMailSender;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;

@Configuration
public class SimpleEmailConfiguration {

  @Bean
  public AmazonSimpleEmailService amazonSimpleEmailService() {
    return AmazonSimpleEmailServiceClientBuilder.standard()
        .build();
  }

  @Bean
  public JavaMailSender javaMailSender(AmazonSimpleEmailService amazonSimpleEmailService) {
    return new SimpleEmailServiceJavaMailSender(amazonSimpleEmailService);
  }
}
