package com.training.aws.profile.service.impl;

import com.training.aws.profile.exceptions.ProfileAlreadyExistsException;
import com.training.aws.profile.exceptions.ProfileNotFoundException;
import com.training.aws.profile.model.Profile;
import com.training.aws.profile.model.constants.Event;
import com.training.aws.profile.repository.ProfileRepository;
import com.training.aws.profile.service.NotificationService;
import com.training.aws.profile.service.ProfileService;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProfileServiceImpl implements ProfileService {

  private final NotificationService notificationService;
  private final ProfileRepository profileRepository;

  @Override
  public List<Profile> getAllProfiles() {
    log.info("Retrieving all profiles");

    List<Profile> profiles = profileRepository.getAll();

    log.info("Found {} profiles", profiles.size());

    return profiles;
  }

  @Override
  public Profile getProfileByEmail(String email) {
    log.info("Looking for profileHolder with email: {}", email);
    Optional<Profile> profileHolder = profileRepository.getByEmail(email);

    if (profileHolder.isPresent()) {
      Profile profile = profileHolder.get();

      log.info("Found 1 profile");
      log.debug("Profile: {}", profile);

      return profile;
    } else {
      log.warn("Profile not found");

      throw new ProfileNotFoundException(email);
    }
  }

  @Override
  public String createProfile(Profile profile) {
    log.info("About to store profile with email: {}", profile.getEmail());
    log.debug("Profile: {}", profile);

    Optional<Profile> currentProfile = profileRepository.getByEmail(profile.getEmail());

    if (!currentProfile.isPresent()) {
      String identifier = profileRepository.save(profile);
      log.info("Profile has been stored");

      notificationService.publish(profile, Event.CREATED);

      return identifier;
    } else {
      log.warn("Profile already exists");

      throw new ProfileAlreadyExistsException(profile.getEmail());
    }
  }

  @Override
  public void deleteProfile(String email) {
    log.info("About to delete profile with email: {}", email);

    Profile profile = getProfileByEmail(email);

    profileRepository.delete(profile);
    log.info("Profile has been deleted");

    notificationService.publish(profile, Event.DELETED);
  }
}
