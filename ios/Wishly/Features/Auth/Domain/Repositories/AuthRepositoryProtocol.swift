import Foundation

/// Contrato del repositorio de autenticación.
/// En Flutter esto equivale a una `abstract class AuthRepository`.
/// Permite desacoplar el Dominio de las librerías concretas (Firebase, GoogleSignIn, etc.).
protocol AuthRepositoryProtocol {
    func signInWithGoogle() async throws -> User
    func signOut() async throws
    func getCurrentUser() -> User?
}
