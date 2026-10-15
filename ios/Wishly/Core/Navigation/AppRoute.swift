import Foundation

/// Define todas las rutas posibles en la aplicación.
/// En Flutter esto sería similar a definir los nombres de las rutas en `go_router` o en `onGenerateRoute`.
enum AppRoute: Hashable {
    case login
    case home
    // Ejemplo para el futuro: case profile(userId: String)
}
