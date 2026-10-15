import Foundation

/// Caso de uso para cerrar la sesión actual.
final class SignOutUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws {
        try await repository.signOut()
    }
}
