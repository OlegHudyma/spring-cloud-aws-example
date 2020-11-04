package com.training.aws.profile.controller;

import com.training.aws.profile.api.ProfileApi;
import com.training.aws.profile.model.Profile;
import com.training.aws.profile.service.ProfileService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ProfileController implements ProfileApi {

  private final ProfileService profileService;

  @Override
  public List<Profile> getAll() {
    return profileService.getAllProfiles();
  }

  @Override
  public Profile getProfileByEmail(String email) {
    return profileService.getProfileByEmail(email);
  }

  @Override
  public String createProfile(Profile profile) {
    return profileService.createProfile(profile);
  }

  @Override
  public void deleteProfile(String email) {
    profileService.deleteProfile(email);
  }
}
