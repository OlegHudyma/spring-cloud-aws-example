package com.training.aws.profile.controller.handler;

import com.training.aws.profile.exceptions.ProfileAlreadyExistsException;
import com.training.aws.profile.exceptions.ProfileNotFoundException;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ProfileControllerExceptionHandler {

  @ExceptionHandler(ProfileNotFoundException.class)
  public void handleProfileNotFoundException(HttpServletResponse response,
      ProfileNotFoundException exception) throws IOException {
    response.sendError(HttpStatus.NOT_FOUND.value(), exception.getMessage());
  }

  @ExceptionHandler(ProfileAlreadyExistsException.class)
  public void handleProfileAlreadyExistsException(HttpServletResponse response,
      ProfileAlreadyExistsException exception) throws IOException {
    response.sendError(HttpStatus.CONFLICT.value(), exception.getMessage());
  }
}
