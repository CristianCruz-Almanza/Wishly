import Foundation

/// Caso de uso para iniciar sesión con Google.
/// En Flutter, los Use Cases suelen representarse con una clase que tiene un método `call()` o `execute()`.
final class SignInWithGoogleUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> User {
        try await repository.signInWithGoogle()
    }
}
