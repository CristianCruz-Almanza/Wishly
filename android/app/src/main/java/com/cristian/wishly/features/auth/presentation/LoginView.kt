package com.cristian.wishly.features.auth.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.cristian.wishly.core.ui.components.AppTextField
import com.cristian.wishly.core.ui.components.GoogleSignInButton
import com.cristian.wishly.core.ui.components.PrimaryButton

@Composable
fun LoginView(
    onNavigateToHome: () -> Unit,
    viewModel: LoginViewModel = remember { LoginViewModel() }
) {
    val uiState by viewModel.uiState.collectAsState()
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }

    LaunchedEffect(uiState.isAuthenticated) {
        if (uiState.isAuthenticated) {
            onNavigateToHome()
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 24.dp)
            .padding(top = 40.dp)
    ) {
        Text(
            text = "Iniciar Sesión",
            fontSize = 32.sp,
            fontWeight = FontWeight.Bold
        )
        
        Spacer(modifier = Modifier.height(20.dp))
        
        AppTextField(
            value = email,
            onValueChange = { email = it },
            placeholder = "Correo electrónico"
        )
        
        Spacer(modifier = Modifier.height(20.dp))
        
        AppTextField(
            value = password,
            onValueChange = { password = it },
            placeholder = "Contraseña",
            isSecure = true
        )
        
        Spacer(modifier = Modifier.height(30.dp))
        
        PrimaryButton(title = "Entrar", onClick = onNavigateToHome)

        Spacer(modifier = Modifier.height(20.dp))

        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.fillMaxWidth()
        ) {
            Box(
                modifier = Modifier
                    .weight(1f)
                    .height(1.dp)
                    .background(Color(0xFFE0E0E0))
            )
            Text(
                text = "o continúa con",
                color = Color.Gray,
                fontSize = 14.sp,
                modifier = Modifier.padding(horizontal = 8.dp)
            )
            Box(
                modifier = Modifier
                    .weight(1f)
                    .height(1.dp)
                    .background(Color(0xFFE0E0E0))
            )
        }

        Spacer(modifier = Modifier.height(20.dp))

        GoogleSignInButton(
            isLoading = uiState.isLoading,
            onClick = { viewModel.signInWithGoogle() }
        )

        if (uiState.errorMessage != null) {
            Spacer(modifier = Modifier.height(12.dp))
            Text(
                text = uiState.errorMessage ?: "",
                color = Color(0xFFD32F2F),
                fontSize = 13.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier.fillMaxWidth()
            )
        }
    }
}
