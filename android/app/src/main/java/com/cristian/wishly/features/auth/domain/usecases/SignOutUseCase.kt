package com.cristian.wishly.features.auth.domain.usecases

import com.cristian.wishly.features.auth.domain.repositories.AuthRepository

/**
 * Caso de uso para cerrar la sesión actual.
 */
class SignOutUseCase(
    private val repository: AuthRepository
) {
    suspend operator fun invoke(): Result<Unit> {
        return repository.signOut()
    }
}
