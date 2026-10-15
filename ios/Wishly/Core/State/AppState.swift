import SwiftUI
import Combine

/// Define el estado general de la aplicación.
/// En Flutter, esto lo harías con un Bloc o Provider a nivel de MaterialApp para decidir qué mostrar.
enum RootScreen {
    case splash
    case main // Cuando ya pasamos el Splash, decidimos si vamos a Login o Home
}

class AppState: ObservableObject {
    @Published var currentRoot: RootScreen = .splash
    
    /// Aquí comprobaremos si el usuario tiene una sesión activa o token guardado
    func initializeApp() {
        // Simulamos una carga asíncrona de 2 segundos (Splash screen)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Cambiamos el estado a main
            self.currentRoot = .main
        }
    }
}
