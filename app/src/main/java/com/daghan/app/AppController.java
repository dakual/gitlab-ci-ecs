package com.daghan.app;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {
  
  @GetMapping("/")
  public Map<String, Object> helloWorld() {
    Map<String, Object> map = new HashMap<>();
    map.put("status", "success");
    map.put("results", "Hello World!");
    return map;
  }

}
