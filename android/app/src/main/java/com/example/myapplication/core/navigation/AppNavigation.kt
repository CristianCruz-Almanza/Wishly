package com.example.myapplication.core.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.myapplication.features.splash.presentation.SplashView
import com.example.myapplication.features.auth.presentation.LoginView
import com.example.myapplication.features.home.presentation.HomeView

@Composable
fun AppNavigation() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = AppRoute.Splash.route) {
        composable(AppRoute.Splash.route) {
            SplashView(onNavigateToMain = {
                navController.navigate(AppRoute.Login.route) {
                    popUpTo(AppRoute.Splash.route) { inclusive = true }
                }
            })
        }
        composable(AppRoute.Login.route) {
            LoginView(onNavigateToHome = {
                navController.navigate(AppRoute.Home.route) {
                    popUpTo(AppRoute.Login.route) { inclusive = true }
                }
            })
        }
        composable(AppRoute.Home.route) {
            HomeView(onLogout = {
                navController.navigate(AppRoute.Login.route) {
                    popUpTo(0) // Clear todo el stack para cerrar sesión
                }
            })
        }
    }
}
