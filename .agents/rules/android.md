---
trigger: model_decision
description: Reglas de arquitectura y estilo para la app Android (Kotlin / Jetpack Compose) en android/. Cargar al leer o editar código Kotlin o Gradle.
---

# 🤖 Reglas Android (Kotlin / Jetpack Compose)

Espejo de las reglas iOS con **paridad 1:1**.
Paquete base / applicationId: **`com.cristian.wishly`** · minSdk 24 · targetSdk 36.
Dependencias declaradas en `gradle/libs.versions.toml` (version catalog). No hardcodear versiones en `build.gradle.kts`.

## 🏗️ Clean Architecture + MVVM (por Features)

### 1. Presentation
- **Views**: funciones `@Composable`. *Equivalente:* SwiftUI `View` / Flutter `Widget`.
- **ViewModels**: extienden `ViewModel`, exponen `StateFlow<UiState>`. *Equivalente:* `@Observable` (Swift) / `Bloc` (Flutter).

### 2. Design System / Componentes (core)
- Wrappers propios en `core/ui/components` (ej. `PrimaryButton`). **No** usar `Button`, `TextField`… de Material directamente en pantallas.

### 3. Domain
- **Entities**: `data class` puros (sin Android/Firebase).
- **Use Cases**: una acción por clase, `suspend operator fun invoke(...)`.
- **Interfaces**: `interface` (equivalente a `protocol` en Swift).

### 4. Data
- **Repositories**: implementan las interfaces del Domain.
- **Data Sources**: Retrofit/Ktor, Firebase SDK, Room/DataStore.
- **DTOs**: `@Serializable` (kotlinx.serialization). Se mapean a Entities.

## ✅ Reglas de implementación
1. Explicar diferencias clave con iOS/Flutter.
2. Inyección de dependencias por constructor.
3. Coroutines + Flow (`suspend`, `viewModelScope`). Nada de callbacks si hay alternativa `suspend` (`kotlinx-coroutines-play-services` → `.await()`).
4. Una responsabilidad por clase (SOLID).

## 📁 Estructura base
```
app/src/main/java/com/cristian/wishly/
├── core/
│   ├── navigation/
│   └── ui/components/
├── ui/theme/
└── features/
    └── <feature>/
        ├── presentation/
        ├── domain/
        └── data/
```
