import SwiftUI
import Combine

/// Equivalente a un GoRouter o un servicio de navegación en Flutter.
/// Usamos `ObservableObject` para que las vistas escuchen sus cambios (idéntico a `ChangeNotifier`).
class Router: ObservableObject {
    // NavigationPath maneja la "pila" (stack) de pantallas.
    @Published var path = NavigationPath()
    
    /// push(Route)
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    /// pop()
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// popUntilRoot() - Ideal para cerrar sesión
    func popToRoot() {
        path.removeLast(path.count)
    }
}
