package com.app.BabyAura.service;

import com.app.BabyAura.model.User;
import com.app.BabyAura.model.UserLoginRequest;
import com.app.BabyAura.model.UserRegistrationRequest;
import com.app.BabyAura.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Validar usuario (login)
    public boolean validateUser(UserLoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername());
        if (user != null) {
            return user.getPassword().equals(request.getPassword());
        }
        return false;
    }

    // Registrar nuevo usuario
    public boolean registerUser(UserRegistrationRequest request) {
    if (userRepository.findByUsername(request.getUsername()) != null) {
        throw new RuntimeException("Username already exists");  // Lanza excepción si el usuario ya existe
    }

    User newUser = new User();
    newUser.setName(request.getName());
    newUser.setEmail(request.getEmail());
    newUser.setUsername(request.getUsername());
    newUser.setPassword(request.getPassword());

    userRepository.save(newUser);
    return true;
}

}
