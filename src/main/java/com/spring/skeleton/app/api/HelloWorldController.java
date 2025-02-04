package com.spring.skeleton.app.api;

import com.spring.skeleton.domain.model.HelloDto;
import com.spring.skeleton.domain.ports.incoming.HelloWorldApi;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/hello")
@Slf4j
public class HelloWorldController implements HelloWorldApi {

  public HelloWorldController() {}

  @GetMapping("/say-hello")
  @Tag(name = "Just a Hello World")
  @Override
  public Mono<ResponseEntity<HelloDto>> sayHello() throws Exception {
    return Mono.just(ResponseEntity.ok(new HelloDto("Hello World!")));
  }
}
