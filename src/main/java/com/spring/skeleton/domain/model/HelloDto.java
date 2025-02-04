package com.spring.skeleton.domain.model;

import lombok.*;

@Data
@RequiredArgsConstructor
@NoArgsConstructor
@ToString
public class HelloDto {

  String error = null;
  @NonNull String message;
}
