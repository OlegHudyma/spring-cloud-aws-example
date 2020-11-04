package com.training.aws.profile;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties
public class ProfileApplication {

  public static void main(String[] args) {
    SpringApplication.run(ProfileApplication.class, args);
  }

}
