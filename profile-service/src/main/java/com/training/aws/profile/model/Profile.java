package com.training.aws.profile.model;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@DynamoDBTable(tableName = "profiles")
public class Profile {

  @NotBlank
  @ApiModelProperty(notes = "User's first name", required = true)
  private String name;

  @NotBlank
  @ApiModelProperty(notes = "User's surname", required = true)
  private String surname;

  @NotBlank
  @Pattern(regexp = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$")
  @ApiModelProperty(required = true, example = "oleg_hudyma@epam.com")
  @DynamoDBHashKey
  private String email;
}
