package {{PACKAGE_NAME}}.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.dynamicColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    val colorScheme = try {
        dynamicColorScheme(LocalContext.current)
    } catch (_: Exception) {
        lightColorScheme()
    }

    MaterialTheme(
        colorScheme = colorScheme,
        content = content
    )
}
