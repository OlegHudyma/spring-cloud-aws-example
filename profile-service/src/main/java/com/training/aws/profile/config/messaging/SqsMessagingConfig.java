package com.training.aws.profile.config.messaging;

import com.amazonaws.services.sqs.AmazonSQSAsync;
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder;
import org.springframework.cloud.aws.messaging.core.QueueMessagingTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SqsMessagingConfig {

  @Bean
  public AmazonSQSAsync amazonSQS() {
    return AmazonSQSAsyncClientBuilder.standard().build();
  }

  @Bean
  public QueueMessagingTemplate queueMessagingTemplate(AmazonSQSAsync amazonSQS) {
    return new QueueMessagingTemplate(amazonSQS);
  }
}
