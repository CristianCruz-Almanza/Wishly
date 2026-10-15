import Foundation

/// Implementación del repositorio de autenticación en iOS.
/// Conecta el Dominio con el Data Source de Firebase.
final class AuthRepository: AuthRepositoryProtocol {
    private let dataSource: FirebaseAuthDataSourceProtocol
    
    init(dataSource: FirebaseAuthDataSourceProtocol = FirebaseAuthDataSource()) {
        self.dataSource = dataSource
    }
    
    func signInWithGoogle() async throws -> User {
        try await dataSource.signInWithGoogle()
    }
    
    func signOut() async throws {
        try dataSource.signOut()
    }
    
    func getCurrentUser() -> User? {
        dataSource.getCurrentUser()
    }
}
