package com.cristian.wishly.features.auth.presentation

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.cristian.wishly.features.auth.data.repositories.AuthRepositoryImpl
import com.cristian.wishly.features.auth.domain.usecases.SignInWithGoogleUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

/**
 * Estado de la pantalla de inicio de sesión en Android.
 * En Flutter, equivale a las clases de estado emitidas por tu Bloc (`LoginState`).
 */
data class LoginUiState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val isAuthenticated: Boolean = false
)

/**
 * ViewModel para LoginView en Jetpack Compose.
 * En Flutter, equivale a tu Cubit o ChangeNotifier.
 */
class LoginViewModel(
    private val signInWithGoogleUseCase: SignInWithGoogleUseCase = SignInWithGoogleUseCase(AuthRepositoryImpl())
) : ViewModel() {

    private val _uiState = MutableStateFlow(LoginUiState())
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    fun signInWithGoogle() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val result = signInWithGoogleUseCase()
            result.fold(
                onSuccess = {
                    _uiState.update { it.copy(isLoading = false, isAuthenticated = true) }
                },
                onFailure = { error ->
                    _uiState.update {
                        it.copy(
                            isLoading = false,
                            errorMessage = error.localizedMessage ?: "Error al iniciar sesión"
                        )
                    }
                }
            )
        }
    }

    fun clearError() {
        _uiState.update { it.copy(errorMessage = null) }
    }
}
