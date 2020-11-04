package com.training.aws.email.notification.model;

import com.training.aws.email.notification.model.constants.Event;
import java.util.UUID;
import lombok.Data;

@Data
public class Message {
  private UUID correlationId;
  private Event event;
  private Profile profile;
}
