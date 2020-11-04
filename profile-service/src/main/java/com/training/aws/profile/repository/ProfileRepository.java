package com.training.aws.profile.repository;

import com.training.aws.profile.model.Profile;
import java.util.List;
import java.util.Optional;

public interface ProfileRepository {

  List<Profile> getAll();

  Optional<Profile> getByEmail(String email);

  String save(Profile profile);

  void delete(Profile profile);
}
