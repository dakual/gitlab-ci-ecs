package com.daghan.app;

import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class AppTest 
{
    @Test
    void hello() {
        AppController controller     = new AppController();
        Map<String, Object> response = controller.helloWorld();
        String status                = response.get("status").toString();

        assertEquals("success", status);
    }
}
