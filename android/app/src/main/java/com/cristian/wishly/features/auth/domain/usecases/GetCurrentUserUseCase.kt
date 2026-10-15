package com.cristian.wishly.features.auth.domain.usecases

import com.cristian.wishly.features.auth.domain.entities.User
import com.cristian.wishly.features.auth.domain.repositories.AuthRepository

/**
 * Caso de uso para obtener el usuario autenticado actualmente en memoria o sesión local.
 */
class GetCurrentUserUseCase(
    private val repository: AuthRepository
) {
    operator fun invoke(): User? {
        return repository.getCurrentUser()
    }
}
