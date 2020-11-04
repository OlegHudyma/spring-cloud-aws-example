package com.training.aws.email.notification.service;

import com.training.aws.email.notification.model.Profile;
import com.training.aws.email.notification.model.constants.Event;
import javax.mail.MessagingException;

public interface CommunicationService {

  void sendCommunication(Profile profile, Event event) throws MessagingException;
}
