package com.cristian.wishly.core.navigation

sealed class AppRoute(val route: String) {
    object Splash : AppRoute("splash")
    object Login : AppRoute("login")
    object Home : AppRoute("home")
}
