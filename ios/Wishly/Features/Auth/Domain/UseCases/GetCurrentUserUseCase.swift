import Foundation

/// Caso de uso para obtener el usuario autenticado actualmente en memoria o sesión local.
final class GetCurrentUserUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> User? {
        repository.getCurrentUser()
    }
}
