package com.cristian.wishly.core.utils

import android.app.Activity
import java.lang.ref.WeakReference

/**
 * Proveedor desacoplado de la Activity actual para APIs de plataforma
 * como CredentialManager o GIDSignIn que requieren una Activity activa.
 */
object ActivityProvider {
    private var currentActivityRef: WeakReference<Activity>? = null

    var currentActivity: Activity?
        get() = currentActivityRef?.get()
        set(value) {
            currentActivityRef = value?.let { WeakReference(it) }
        }
}
