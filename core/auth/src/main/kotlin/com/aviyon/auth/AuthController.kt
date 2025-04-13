package com.aviyon.auth

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/auth")
class AuthController {
    @PostMapping("/login")
    fun login(@RequestBody request: LoginRequest): String {
        // TODO: Validate credentials against DB
        return JwtUtil.generateToken(request.username)
    }

    @PostMapping("/signup")
    fun signup(@RequestBody request: SignupRequest): String {
        // TODO: Save user to DB
        return JwtUtil.generateToken(request.username)
    }
}

data class LoginRequest(val username: String, val password: String)
data class SignupRequest(val username: String, val password: String, val email: String)
