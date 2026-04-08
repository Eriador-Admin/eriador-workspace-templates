import SwiftUI

struct ContentView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "swift")
                    .font(.system(size: 60))
                    .foregroundStyle(.orange)

                Text("Welcome to {{APP_NAME}}")
                    .font(.title)
                    .fontWeight(.bold)

                Text(viewModel.message)
                    .font(.body)
                    .foregroundStyle(.secondary)

                Button("Tap Me") {
                    viewModel.onTap()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("{{APP_NAME}}")
        }
    }
}

#Preview {
    ContentView()
}
