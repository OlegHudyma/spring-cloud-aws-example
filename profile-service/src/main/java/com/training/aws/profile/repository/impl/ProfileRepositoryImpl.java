package com.training.aws.profile.repository.impl;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.training.aws.profile.model.Profile;
import com.training.aws.profile.repository.ProfileRepository;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ProfileRepositoryImpl implements ProfileRepository {

  private final DynamoDBMapper dynamoDBMapper;

  @Override
  public List<Profile> getAll() {
    return dynamoDBMapper.scan(Profile.class, new DynamoDBScanExpression());
  }

  @Override
  public Optional<Profile> getByEmail(String email) {
    return Optional.ofNullable(dynamoDBMapper.load(Profile.class, email));
  }

  @Override
  public String save(Profile profile) {
    dynamoDBMapper.save(profile);

    return profile.getEmail();
  }

  @Override
  public void delete(Profile profile) {
    dynamoDBMapper.delete(profile);
  }
}
