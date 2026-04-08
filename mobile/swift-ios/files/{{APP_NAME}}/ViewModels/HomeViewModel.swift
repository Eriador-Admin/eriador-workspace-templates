import Foundation

@Observable
class HomeViewModel {
    var message = "Your SwiftUI app is ready."
    var tapCount = 0

    func onTap() {
        tapCount += 1
        message = "Tapped \(tapCount) time\(tapCount == 1 ? "" : "s")!"
    }
}
