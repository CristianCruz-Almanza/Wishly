package com.example.myapplication.features.auth.presentation

import androidx.compose.foundation.layout.*
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.myapplication.core.ui.components.AppTextField
import com.example.myapplication.core.ui.components.PrimaryButton

@Composable
fun LoginView(onNavigateToHome: () -> Unit) {
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }

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
    }
}
