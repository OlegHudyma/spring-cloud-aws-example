package com.training.aws.profile.api;

import com.training.aws.profile.model.Profile;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import java.util.List;
import javax.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

@Api(tags = "Profile Api")
@RequestMapping(path = "profiles")
public interface ProfileApi {

  @ApiResponse(code = 200, message = "OK")
  @GetMapping
  @ResponseStatus(HttpStatus.OK)
  @ApiOperation(value = "Retrieves list of profiles")
  List<Profile> getAll();

  @ApiResponses(value = {
      @ApiResponse(code = 200, message = "OK"),
      @ApiResponse(code = 404, message = "Not Found")
  })
  @GetMapping(path = "/{email}")
  @ResponseStatus(HttpStatus.OK)
  @ApiOperation(value = "Retrieves single Profile by email address")
  Profile getProfileByEmail(@PathVariable("email") String email);

  @ApiResponses(value = {
      @ApiResponse(code = 201, message = "Created"),
      @ApiResponse(code = 409, message = "Conflict")
  })
  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  @ApiOperation(value = "Creates Profile")
  String createProfile(@RequestBody @Valid Profile profile);

  @ApiResponse(code = 202, message = "Accepted")
  @DeleteMapping(path = "/{email}")
  @ResponseStatus(HttpStatus.ACCEPTED)
  @ApiOperation(value = "Deletes single profile by email")
  void deleteProfile(@PathVariable("email") String email);
}
