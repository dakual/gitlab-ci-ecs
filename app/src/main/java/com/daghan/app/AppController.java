package com.daghan.app;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {

  @GetMapping("/")
  public Map<String, Object> index() {
    Map<String, Object> map = new HashMap<>();
    map.put("status", "success");
    map.put("results", "Hello World!");

    return map;
  }

  @GetMapping("/efs-test")
  public Map<String, Object> efs(@RequestParam(value = "m", required = false) String m) {
    Map<String, Object> map = new HashMap<>();

    String efsPath = System.getenv("EFS_PATH");
    if (efsPath == null) {
      map.put("status", "error");
      map.put("message", "EFS_PATH is null");

      System.out.println("EFS_PATH is null");

      return map;
    }

    try {
      File file   = new File(efsPath + "/sample.txt");
      String text = null;

      if(m != null) {
        BufferedWriter out = new BufferedWriter(new FileWriter(file));
        out.write(m);
        out.close();
      }

      try {
        try(BufferedReader bufferedReader = new BufferedReader(new FileReader(file))) {
          text = bufferedReader.readLine();
        }
      } catch(Exception e) {}

      map.put("status", "success");
      map.put("content", text);
    } catch (IOException e) {
      map.put("status", "error");
      map.put("message", e.getMessage());

      e.printStackTrace();      
    }

    return map;
  }

}
