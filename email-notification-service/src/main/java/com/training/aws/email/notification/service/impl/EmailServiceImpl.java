package com.training.aws.email.notification.service.impl;

import com.training.aws.email.notification.service.EmailService;
import java.nio.charset.StandardCharsets;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

  private final JavaMailSender javaMailSender;

  @Override
  public void sendEmail(String subject, String text, String from, String[] to)
      throws MessagingException {
    MimeMessage message = javaMailSender.createMimeMessage();

    MimeMessageHelper helper =
        new MimeMessageHelper(
            message,
            MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
            StandardCharsets.UTF_8.name());

    helper.setTo(to);
    helper.setText(text, true);
    helper.setSubject(subject);
    helper.setFrom(from);

    javaMailSender.send(message);
  }
}
