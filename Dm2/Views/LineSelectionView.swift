import SwiftUI

struct LineSelectionView: View {
    @ObservedObject var viewModel: PathViewModel

    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(viewModel.lines.indices, id: \.self) { index in
                        VStack {
                            Spacer()
                            Text(viewModel.lines[index].name)
                                .font(.custom("AgrandirVariable_Bold", size: 60))
                                .rotationEffect(.degrees(90))
                                .frame(width: geometry.size.height, height: geometry.size.width / 2)
                                .foregroundColor(index == 0 ? .black : .white)
                            Spacer()
                        }
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .background(index == 0 ? Color.white : Color.black)
                    }
                }
                .accessibilityAddTraits(.allowsDirectInteraction)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let direction = value.translation.width < 0 ? 0 : 1  // Determina la direzione del swipe
                            let selectedLine = viewModel.lines[direction]
                            viewModel.selectLine(selectedLine)
                        }
                )
                .navigationDestination(
                    isPresented: $viewModel.shouldNavigateToStations,
                    destination: {StationSelectionView(viewModel: viewModel, line: viewModel.selectedLine ?? viewModel.lines.first!)}
                )
            }
        }
    }
}

#Preview {
    LineSelectionView(viewModel: PathViewModel())
}
