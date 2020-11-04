package com.training.aws.profile.exceptions;

public class ProfileAlreadyExistsException extends RuntimeException {

  private static final String MESSAGE = "Profile with email %s already exists";

  public ProfileAlreadyExistsException(String email) {
    super(String.format(MESSAGE, email));
  }
}
