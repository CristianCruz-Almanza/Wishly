package com.cristian.wishly.features.auth.data.repositories

import com.cristian.wishly.features.auth.data.datasources.FirebaseAuthDataSource
import com.cristian.wishly.features.auth.data.datasources.FirebaseAuthDataSourceImpl
import com.cristian.wishly.features.auth.domain.entities.User
import com.cristian.wishly.features.auth.domain.repositories.AuthRepository

/**
 * Implementación del repositorio de autenticación en Android.
 * Conecta el Dominio con el Data Source de Firebase Auth / CredentialManager.
 */
class AuthRepositoryImpl(
    private val dataSource: FirebaseAuthDataSource = FirebaseAuthDataSourceImpl()
) : AuthRepository {

    override suspend fun signInWithGoogle(): Result<User> {
        return try {
            val user = dataSource.signInWithGoogle()
            Result.success(user)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun signOut(): Result<Unit> {
        return try {
            dataSource.signOut()
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override fun getCurrentUser(): User? {
        return dataSource.getCurrentUser()
    }
}
