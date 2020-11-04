package com.training.aws.profile.model;

import com.training.aws.profile.model.constants.Event;
import java.util.UUID;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Message {

  private UUID correlationId;
  private Event event;
  private Profile profile;
}
