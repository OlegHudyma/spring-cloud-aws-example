package com.training.aws.email.notification.service;

import javax.mail.MessagingException;

public interface EmailService {

  void sendEmail(String subject, String text, String from, String[] to)
      throws MessagingException;
}
