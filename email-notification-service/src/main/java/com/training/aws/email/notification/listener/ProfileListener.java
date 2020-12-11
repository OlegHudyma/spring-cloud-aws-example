package com.training.aws.email.notification.listener;

import com.training.aws.email.notification.model.Message;
import com.training.aws.email.notification.service.CommunicationService;
import javax.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.aws.messaging.listener.annotation.SqsListener;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ProfileListener {

  private final CommunicationService communicationService;

  @SqsListener("profile-email-notification-queue")
  public void processProfile(Message message) throws MessagingException {
    log.info("Message {} received", message.getCorrelationId());

    communicationService.sendCommunication(message.getProfile(), message.getEvent());

    log.info("Communication has been sent");
  }
}
