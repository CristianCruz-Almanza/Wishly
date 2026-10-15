# 🔥 Firebase Setup

Proyecto Firebase: **Wishly**. Ambas apps usan el identificador **`com.cristian.wishly`**.

> [!IMPORTANT]
> Los archivos de configuración **no se suben al repo** (están en `.gitignore`). Cada desarrollador los descarga desde la consola de Firebase.

| Plataforma | Archivo | Ubicación |
|------------|---------|-----------|
| iOS | `GoogleService-Info.plist` | `ios/Wishly/GoogleService-Info.plist` |
| Android | `google-services.json` | `android/app/google-services.json` |

## 1. Registrar las apps
1. Consola Firebase → proyecto **Wishly** → *Agregar app*.
2. **iOS**: Bundle ID `com.cristian.wishly` → descargar `GoogleService-Info.plist`.
3. **Android**: package `com.cristian.wishly` → añadir huella **SHA-1** (ver abajo) → descargar `google-services.json`.

## 2. Habilitar Google Sign-In
Firebase → **Authentication** → *Sign-in method* → **Google** → Habilitar → guardar.

> [!NOTE]
> Si añades la SHA-1 o habilitas Google **después** de descargar los archivos, vuelve a descargarlos: el `google-services.json` debe incluir el `oauth_client` de tipo web (client_type 3) y el plist debe contener `CLIENT_ID` y `REVERSED_CLIENT_ID`.

## 3. Android — huella SHA-1 (debug)
```bash
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | grep SHA1
```
Pegar el valor en Firebase → Configuración del proyecto → app Android → *Agregar huella digital*.
Para release, repetir con el keystore de release (y la SHA-1 de Play App Signing).

## 4. iOS — URL scheme
Google Sign-In vuelve a la app mediante un URL scheme igual al `REVERSED_CLIENT_ID` del plist
(`com.googleusercontent.apps.XXXX`). Se registra en el target → *Info* → *URL Types*.
