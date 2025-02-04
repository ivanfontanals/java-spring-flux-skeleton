package com.spring.skeleton.domain.ports.incoming;

import com.spring.skeleton.domain.model.HelloDto;
import org.springframework.http.ResponseEntity;
import reactor.core.publisher.Mono;

public interface HelloWorldApi {
  Mono<ResponseEntity<HelloDto>> sayHello() throws Exception;
}
