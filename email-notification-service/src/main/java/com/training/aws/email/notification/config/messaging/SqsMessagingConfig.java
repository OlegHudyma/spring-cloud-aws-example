package com.training.aws.email.notification.config.messaging;

import com.amazonaws.services.sqs.AmazonSQSAsync;
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder;
import java.util.Collections;
import org.springframework.cloud.aws.messaging.config.QueueMessageHandlerFactory;
import org.springframework.cloud.aws.messaging.core.QueueMessagingTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.converter.MappingJackson2MessageConverter;
import org.springframework.messaging.handler.annotation.support.PayloadMethodArgumentResolver;

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

  @Bean
  public QueueMessageHandlerFactory queueMessageHandlerFactory() {
    QueueMessageHandlerFactory factory = new QueueMessageHandlerFactory();
    MappingJackson2MessageConverter messageConverter = new MappingJackson2MessageConverter();

    //set strict content type match to false
    messageConverter.setStrictContentTypeMatch(false);
    factory.setArgumentResolvers(Collections.singletonList(
        new PayloadMethodArgumentResolver(messageConverter)));
    return factory;
  }
}
