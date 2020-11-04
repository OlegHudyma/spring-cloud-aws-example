package com.training.aws.email.notification.service.impl;

import com.training.aws.email.notification.config.properties.TemplatesProperties;
import com.training.aws.email.notification.config.properties.TemplatesProperties.Template;
import com.training.aws.email.notification.model.Profile;
import com.training.aws.email.notification.model.constants.Event;
import com.training.aws.email.notification.service.CommunicationService;
import com.training.aws.email.notification.service.EmailService;
import java.util.Optional;
import javax.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.thymeleaf.ITemplateEngine;
import org.thymeleaf.context.Context;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunicationServiceImpl implements CommunicationService {

  private static final String NAME = "name";
  private static final String SURNAME = "surname";
  private static final String EMAIL = "email";

  private final EmailService emailService;
  private final ITemplateEngine templateEngine;
  private final TemplatesProperties templatesProperties;

  @Override
  public void sendCommunication(Profile profile, Event event) throws MessagingException {
    log.info("Building email html from template");

    Optional<Template> templateHolder = templatesProperties.getTemplates()
        .stream()
        .filter((t) -> t.getEvent().equals(event))
        .findFirst();

    if (templateHolder.isPresent()) {
      Template template = templateHolder.get();

      Context context = populateContext(profile);

      String subject = template.getSubject();
      String from = template.getFrom();
      String[] to = {profile.getEmail()};

      String html = templateEngine.process(template.getTemplate(), context);

      log.info("Sending email with subject: '{}' to {}", subject, to);

      emailService.sendEmail(subject, html, from, to);
    } else {
      log.error("Template not found for {} event", event);
    }
  }

  private Context populateContext(Profile profile) {
    Context context = new Context();

    context.setVariable(NAME, profile.getName());
    context.setVariable(SURNAME, profile.getSurname());
    context.setVariable(EMAIL, profile.getEmail());

    return context;
  }
}
