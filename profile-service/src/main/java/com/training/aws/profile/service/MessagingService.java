package com.training.aws.profile.service;

import com.training.aws.profile.model.Profile;
import com.training.aws.profile.model.constants.Event;

public interface MessagingService {

  void publish(Profile profile, Event event);
}
