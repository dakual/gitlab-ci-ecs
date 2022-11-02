package com.daghan.app;

import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class AppTest 
{
    @Test
    void test1() {
        AppController controller     = new AppController();
        Map<String, Object> response = controller.index();
        String status                = response.get("status").toString();

        assertEquals("success", status);
    }

    @Test
    void test2() {
        assertEquals(1, 1);
    }

    @Test
    void test3() {
        assertEquals("ok", "ok");
    }
}
