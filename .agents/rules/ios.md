---
trigger: model_decision
description: Reglas de arquitectura y estilo para la app iOS (SwiftUI) en ios/. Cargar al leer o editar código Swift.
---

# 🍎 Reglas iOS (Swift / SwiftUI)

Proyecto: `ios/Wishly.xcodeproj` · Bundle ID `com.cristian.wishly` · iOS 26.2+ · Xcode 26+.
Dependencias por **Swift Package Manager** (nada de CocoaPods).

## 🏗️ Clean Architecture + MVVM

### 1. Presentation
- **Views**: `SwiftUI`. *Flutter:* `StatelessWidget` / `StatefulWidget`. Solo dibujan UI.
- **ViewModels**: `@Observable` (o `ObservableObject`) marcados `@MainActor`. *Flutter:* `ChangeNotifier` / `Bloc`.

### 2. Design System / Componentes (Core)
- En SwiftUI los "Widgets" también son `View`. Todo lo reutilizable vive en `Core/UI/Components` o `Core/DesignSystem`.

### 3. Domain
- **Entities**: `struct` puros, sin imports de frameworks externos.
- **Use Cases**: una acción del usuario por clase (ej. `SignInWithGoogleUseCase`), con `func execute(...) async throws`.
- **Protocols**: contratos. *Flutter:* `abstract class`.

### 4. Data
- **Repositories**: implementan los protocolos del Domain.
- **Data Sources**: red (`URLSession`), Firebase SDK, almacenamiento local.
- **DTOs**: `Codable`, solo para parseo. Se mapean a Entities.

## ✅ Reglas de implementación
1. Explicar paso a paso cada archivo con analogía Flutter.
2. Inyección de dependencias por constructor; nada de singletons en Domain/Presentation.
3. Swift moderno: `async/await`, `Task`, `@MainActor`. Evitar completion handlers.
4. Una responsabilidad por tipo (SOLID).

## 📁 Estructura base
```
Wishly/
├── Core/
│   ├── DesignSystem/   (Colors, Typography, AppTheme, Components)
│   ├── UI/Components/  (PrimaryButton, AppTextField…)
│   ├── Navigation/  Network/  State/
└── Features/
    └── <Feature>/
        ├── Presentation/ (Views, ViewModels, Components)
        ├── Domain/       (Entities, UseCases, Repositories)
        └── Data/         (DataSources, Repositories, DTOs)
```
