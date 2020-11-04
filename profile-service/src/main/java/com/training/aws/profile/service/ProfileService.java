package com.training.aws.profile.service;

import com.training.aws.profile.model.Profile;
import java.util.List;

public interface ProfileService {

  List<Profile> getAllProfiles();

  Profile getProfileByEmail(String email);

  String createProfile(Profile profile);

  void deleteProfile(String email);
}
