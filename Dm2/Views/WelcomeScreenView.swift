import SwiftUI
import AVFoundation

struct WelcomeScreen: View {
    @ObservedObject var viewModel: PathViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isActive {
                LineSelectionView(viewModel: viewModel)
            } else {
                Text("Benvenuto a\nmunicipio")
                    .font(.custom("AgrandirVariable_Bold", size: 56))
                    .fontWeight(.bold)
                    .rotationEffect(.degrees(90))
                    .frame(width: UIScreen.main.bounds.height)
                    .multilineTextAlignment(.leading)
                    .transition(.opacity)
                    .accessibilityHidden(true)  // Nasconde questo testo agli assistenti di accessibilità
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .foregroundColor(.white)
    }
}
