package com;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 袁毅雄
 * @description
 * @date 2019/8/6
 */
@EnableAutoConfiguration
@SpringBootApplication
@RestController
@Slf4j
public class StartApplication {

    public static void main(String[] args) {
        SpringApplication.run(StartApplication.class, args);
    }

    @GetMapping("/println")
    public String println() {
        System.out.println("我是println日志输出");
        return "println:测试Jenkins持续性交付";
    }

    @GetMapping("/log")
    public String log() {
        log.error("我是error日志输出");
        log.warn("我是warn日志输出");
        log.info("我是info日志输出");
        log.debug("我是debug日志输出");
        log.trace("我是trace日志输出");
        return "log:测试Jenkins持续性交付";
    }
}
