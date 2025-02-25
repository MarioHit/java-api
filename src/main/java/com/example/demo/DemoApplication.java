package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {

		SpringApplication.run(DemoApplication.class, args);
	}

}

@RestController
class DemoController {
	@GetMapping("/hello")
	public String hello(){
		return "Hello biath";
	}


	@GetMapping("/")
	public String ACCUEIL(){
		return "Page d'accueil hahah";
	}

	@GetMapping("/bye")
	public String bye(){
		return "Bayi bayi bayi";
	}
}
