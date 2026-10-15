import Foundation
import Combine

/// Estado de la pantalla de inicio de sesión.
/// En Flutter, esto equivale al estado emitido por tu `Bloc` o las propiedades de tu `ChangeNotifier`.
struct LoginUiState {
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var isAuthenticated: Bool = false
}

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var state = LoginUiState()
    
    private let signInWithGoogleUseCase: SignInWithGoogleUseCase
    
    init(signInWithGoogleUseCase: SignInWithGoogleUseCase = SignInWithGoogleUseCase(repository: AuthRepository())) {
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
    }
    
    func signInWithGoogle() async {
        state.isLoading = true
        state.errorMessage = nil
        
        do {
            _ = try await signInWithGoogleUseCase.execute()
            state.isLoading = false
            state.isAuthenticated = true
        } catch {
            state.isLoading = false
            state.errorMessage = error.localizedDescription
        }
    }
    
    func clearError() {
        state.errorMessage = nil
    }
}
