import Foundation

/// Errores tipados de red compartidos por todos los módulos.
public enum NetworkError: LocalizedError, Sendable {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case noInternet
    case notFound
    case unknown(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "La URL del servicio no es válida."
        case .serverError(let code): return "Error del servidor con código de estado: \(code)."
        case .decodingError: return "No se pudo procesar la respuesta de datos."
        case .noInternet: return "Sin conexión a internet."
        case .notFound: return "El recurso solicitado no fue encontrado."
        case .unknown(let msg): return msg
        }
    }
}
