package com.aviyon.auth

import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import java.util.Date

object JwtUtil {
    private val SECRET_KEY = System.getenv("JWT_SECRET") ?: "default-secret"
    private const val EXPIRATION_TIME = 86400000 // 1 day

    fun generateToken(username: String): String {
        return Jwts.builder()
            .setSubject(username)
            .setIssuedAt(Date())
            .setExpiration(Date(System.currentTimeMillis() + EXPIRATION_TIME))
            .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
            .compact()
    }

    fun validateToken(token: String): Boolean {
        return try {
            Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token)
            true
        } catch (e: Exception) {
            false
        }
    }
}
