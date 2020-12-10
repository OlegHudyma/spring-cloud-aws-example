package com.training.aws.profile.service.impl;

import com.training.aws.profile.config.properties.MessagingProperties;
import com.training.aws.profile.model.Message;
import com.training.aws.profile.model.Profile;
import com.training.aws.profile.model.constants.Event;
import com.training.aws.profile.service.NotificationService;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.aws.messaging.core.NotificationMessagingTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

  private final MessagingProperties messagingProperties;
  private final NotificationMessagingTemplate notificationMessagingTemplate;

  @Override
  public void publish(Profile profile, Event event) {
    log.info("About to publish {} event", event);
    log.debug("Profile: {}", profile);

    Message message = Message.builder()
        .correlationId(UUID.randomUUID())
        .event(event)
        .profile(profile)
        .build();
    log.debug("Message: {}", message);

    notificationMessagingTemplate.convertAndSend(messagingProperties.getTopic(), message);

    log.info("Message has been pushed");
  }
}
