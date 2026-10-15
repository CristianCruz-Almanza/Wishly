package com.cristian.wishly.features.auth.domain.usecases

import com.cristian.wishly.features.auth.domain.entities.User
import com.cristian.wishly.features.auth.domain.repositories.AuthRepository

/**
 * Caso de uso para iniciar sesión con Google.
 * En Flutter, equivale a un UseCase con operador `call()`.
 * En Kotlin, usamos `operator fun invoke()` para poder llamarlo como función: `signInWithGoogleUseCase()`.
 */
class SignInWithGoogleUseCase(
    private val repository: AuthRepository
) {
    suspend operator fun invoke(): Result<User> {
        return repository.signInWithGoogle()
    }
}
