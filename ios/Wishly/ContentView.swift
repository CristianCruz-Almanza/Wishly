import SwiftUI
import Combine

/// Ensamblador principal de la aplicación.
/// En Flutter esto sería como tu `MaterialApp` donde configuras las rutas y el estado inicial.
struct ContentView: View {
    // Inicializamos el estado global y el router (similar a crear Providers/Blocs en la raíz)
    @StateObject private var appState = AppState()
    @StateObject private var router = Router()
    
    var body: some View {
        Group {
            switch appState.currentRoot {
            case .splash:
                SplashView()
                    .onAppear {
                        // Inicia el chequeo (ej. ¿hay token guardado?)
                        appState.initializeApp()
                    }
                
            case .main:
                // `NavigationStack` es el equivalente moderno a `Navigator` de Flutter.
                NavigationStack(path: $router.path) {
                    // Pantalla por defecto al entrar al stack principal
                    LoginView()
                        // Aquí definimos nuestro mapa de rutas (como el `routes` de MaterialApp)
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .login:
                                LoginView()
                            case .home:
                                HomeView()
                            }
                        }
                }
                // Inyectamos el router en el "árbol de widgets" para que cualquier hijo pueda navegar
                .environmentObject(router)
            }
        }
    }
}

#Preview {
    ContentView()
}
