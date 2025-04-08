package com.app.BabyAura.controller;

import com.app.BabyAura.model.ResponseMessage;
import com.app.BabyAura.model.UserLoginRequest;
import com.app.BabyAura.model.UserRegistrationRequest;
import com.app.BabyAura.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public ResponseEntity<ResponseMessage> login(@RequestBody UserLoginRequest request) {
        boolean success = userService.validateUser(request);
        if (success) {
            return ResponseEntity.ok(new ResponseMessage(true, "Login Successful"));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ResponseMessage(false, "Invalid credentials"));
        }
    }

    @PostMapping("/register")
    public ResponseEntity<ResponseMessage> register(@RequestBody UserRegistrationRequest request) {
        try {
            boolean success = userService.registerUser(request);
            if (success) {
                return ResponseEntity.ok(new ResponseMessage(true, "Registration Successful"));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(new ResponseMessage(false, "Registration failed"));
            }
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ResponseMessage(false, e.getMessage()));
        }
    }
}
