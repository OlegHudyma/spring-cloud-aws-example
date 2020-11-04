package com.training.aws.profile.exceptions;

public class ProfileNotFoundException extends RuntimeException {

  private static final String MESSAGE = "Profile with email %s not found";

  public ProfileNotFoundException(String email) {
    super(String.format(MESSAGE, email));
  }
}
