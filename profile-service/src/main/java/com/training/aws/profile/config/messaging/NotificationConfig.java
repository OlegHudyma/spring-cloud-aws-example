package com.training.aws.profile.config.messaging;

import com.amazonaws.services.sns.AmazonSNSAsync;
import com.amazonaws.services.sns.AmazonSNSAsyncClientBuilder;
import org.springframework.cloud.aws.messaging.core.NotificationMessagingTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class NotificationConfig {

  @Bean
  public AmazonSNSAsync amazonSns() {
    return AmazonSNSAsyncClientBuilder.standard().build();
  }

  @Bean
  public NotificationMessagingTemplate queueMessagingTemplate(AmazonSNSAsync amazonSns) {
    return new NotificationMessagingTemplate(amazonSns);
  }
}
