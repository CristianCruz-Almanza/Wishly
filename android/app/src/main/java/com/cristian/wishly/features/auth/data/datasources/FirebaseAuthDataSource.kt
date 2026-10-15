package com.cristian.wishly.features.auth.data.datasources

import androidx.credentials.ClearCredentialStateRequest
import androidx.credentials.CredentialManager
import androidx.credentials.CustomCredential
import androidx.credentials.GetCredentialRequest
import androidx.credentials.exceptions.GetCredentialCancellationException
import com.cristian.wishly.R
import com.cristian.wishly.core.utils.ActivityProvider
import com.cristian.wishly.features.auth.domain.entities.User
import com.google.android.libraries.identity.googleid.GetGoogleIdOption
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.tasks.await

/**
 * Contrato del Data Source de Firebase Auth en Android.
 */
interface FirebaseAuthDataSource {
    suspend fun signInWithGoogle(): User
    suspend fun signOut()
    fun getCurrentUser(): User?
}

/**
 * Implementación oficial usando CredentialManager + Firebase Auth.
 */
class FirebaseAuthDataSourceImpl(
    private val firebaseAuth: FirebaseAuth = FirebaseAuth.getInstance()
) : FirebaseAuthDataSource {

    override suspend fun signInWithGoogle(): User {
        val activity = ActivityProvider.currentActivity
            ?: throw IllegalStateException("No hay una actividad activa para presentar Google Sign-In.")

        val serverClientId = activity.getString(R.string.default_web_client_id)

        val googleIdOption = GetGoogleIdOption.Builder()
            .setFilterByAuthorizedAccounts(false)
            .setServerClientId(serverClientId)
            .setAutoSelectEnabled(false)
            .build()

        val request = GetCredentialRequest.Builder()
            .addCredentialOption(googleIdOption)
            .build()

        val credentialManager = CredentialManager.create(activity)
        val result = try {
            credentialManager.getCredential(
                context = activity,
                request = request
            )
        } catch (e: GetCredentialCancellationException) {
            throw Exception("Inicio de sesión con Google cancelado.")
        }

        val credential = result.credential
        val idToken = when {
            credential is CustomCredential && credential.type == GoogleIdTokenCredential.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL -> {
                val googleIdTokenCredential = GoogleIdTokenCredential.createFrom(credential.data)
                googleIdTokenCredential.idToken
            }
            else -> throw IllegalStateException("Tipo de credencial no reconocido: ${credential.type}")
        }

        val authCredential = GoogleAuthProvider.getCredential(idToken, null)
        val authResult = firebaseAuth.signInWithCredential(authCredential).await()
        val firebaseUser = authResult.user
            ?: throw IllegalStateException("Firebase no retornó ningún usuario.")

        return User(
            id = firebaseUser.uid,
            email = firebaseUser.email.orEmpty(),
            displayName = firebaseUser.displayName.orEmpty(),
            photoUrl = firebaseUser.photoUrl?.toString()
        )
    }

    override suspend fun signOut() {
        val activity = ActivityProvider.currentActivity
        if (activity != null) {
            val credentialManager = CredentialManager.create(activity)
            try {
                credentialManager.clearCredentialState(ClearCredentialStateRequest())
            } catch (_: Exception) {}
        }
        firebaseAuth.signOut()
    }

    override fun getCurrentUser(): User? {
        val firebaseUser = firebaseAuth.currentUser ?: return null
        return User(
            id = firebaseUser.uid,
            email = firebaseUser.email.orEmpty(),
            displayName = firebaseUser.displayName.orEmpty(),
            photoUrl = firebaseUser.photoUrl?.toString()
        )
    }
}
