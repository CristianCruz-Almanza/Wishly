package com.cristian.wishly.features.auth.domain.entities

/**
 * Entidad pura que representa un usuario autenticado en la aplicación.
 * En Flutter, esto equivale a tu clase modelo inmutable `User`.
 */
data class User(
    val id: String,
    val email: String,
    val displayName: String,
    val photoUrl: String?
)
