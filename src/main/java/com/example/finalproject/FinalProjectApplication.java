package com.example.finalproject;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.IOException;

@SpringBootApplication
@EnableScheduling
public class FinalProjectApplication implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication.run(FinalProjectApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        // 在这里编写启动时执行的逻辑
        openBrowser("http://localhost:8080/login");  // 替换成你的应用程序的实际 URL
    }

    private void openBrowser(String url) {
        try {
            // 通过执行系统命令打开浏览器
            String os = System.getProperty("os.name").toLowerCase();

            if (os.contains("win")) {
                Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler " + url);
            } else if (os.contains("nix") || os.contains("nux") || os.contains("mac")) {
                Runtime.getRuntime().exec("open " + url);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
