package com.training.aws.email.notification.config.properties;

import com.training.aws.email.notification.model.constants.Event;
import java.util.List;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties
public class TemplatesProperties {

  private List<Template> templates;

  @Data
  public static class Template {

    private String from;
    private String subject;
    private String template;

    private Event event;
  }
}
