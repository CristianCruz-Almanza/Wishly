package com.cristian.wishly.features.auth.domain.repositories

import com.cristian.wishly.features.auth.domain.entities.User

/**
 * Contrato del repositorio de autenticación.
 * En Flutter esto equivale a una `abstract class AuthRepository`.
 * Permite desacoplar el Dominio de las librerías concretas (Firebase, CredentialManager, etc.).
 */
interface AuthRepository {
    suspend fun signInWithGoogle(): Result<User>
    suspend fun signOut(): Result<Unit>
    fun getCurrentUser(): User?
}
