package {{PACKAGE_NAME}}.viewmodel

import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class HomeViewModel : ViewModel() {
    private val _message = MutableStateFlow("Your Compose app is ready.")
    val message: StateFlow<String> = _message

    private var tapCount = 0

    fun onTap() {
        tapCount++
        _message.value = "Tapped $tapCount time${if (tapCount == 1) "" else "s"}!"
    }
}
