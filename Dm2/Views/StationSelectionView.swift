import SwiftUI

struct StationSelectionView: View {
    @ObservedObject var viewModel: PathViewModel
    var line: Line

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(line.stations.indices, id: \.self) { index in
                    VStack {
                        Spacer()
                        Text(line.stations[index])
                            .font(.custom("AgrandirVariable_Bold", size: 56))
                            .rotationEffect(.degrees(90))
                            .frame(width: geometry.size.height, height: geometry.size.width / 2)
                            .foregroundColor(index == 0 ? .white : .black)
                        Spacer()
                    }
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                    .background(index == 0 ? Color.black : Color.white)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let direction = value.translation.width < 0 ? 0 : 1  // Determina la direzione del swipe
                        let selectedStation = line.stations[direction]
                        viewModel.selectStation(selectedStation)
                    }
            )
            .navigationDestination(
                isPresented: $viewModel.navigationTrigger,
                destination: {PathFindView(destination: viewModel.selectedStation ?? "No destination selected")}
            )
        }
        .onAppear {
            viewModel.resetNavigation()
        }
    }
}
