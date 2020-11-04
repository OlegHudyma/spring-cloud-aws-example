package com.training.aws.profile.service.impl;

import com.training.aws.profile.config.properties.MessagingProperties;
import com.training.aws.profile.model.Message;
import com.training.aws.profile.model.Profile;
import com.training.aws.profile.model.constants.Event;
import com.training.aws.profile.service.MessagingService;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.aws.messaging.core.QueueMessagingTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MessagingServiceImpl implements MessagingService {

  private final MessagingProperties messagingProperties;
  private final QueueMessagingTemplate queueMessagingTemplate;

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

    queueMessagingTemplate.convertAndSend(messagingProperties.getQueue(), message);

    log.info("Message has been pushed");
  }
}
