import SwiftUI

struct StationSelectionView: View {
    @ObservedObject var viewModel: PathViewModel
    var line: Line

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(line.stations, id: \.self) { station in
                    Text(station)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        .foregroundColor(.white)
                        .background(viewModel.selectedStation == station ? Color.gray : Color.black)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let stationIndex = value.translation.width < 0 ? 0 : 1 // Assume sempre due stazioni
                        let selectedStation = line.stations[stationIndex]
                        viewModel.selectStation(selectedStation)
                    }
            ).onAppear {
                viewModel.shouldNavigateToStations = false
            }

            .onChange(of: viewModel.selectedStation) { newStation in
                if newStation != nil && !viewModel.navigationTrigger {
                    viewModel.navigationTrigger = true
                }
            }

            .onDisappear {
                if !viewModel.navigationTrigger {
                    viewModel.resetNavigation()
                }
            }


            .background(
                NavigationLink(
                    destination: PathFindView(destination: viewModel.selectedStation ?? "No destination selected"),
                    isActive: $viewModel.navigationTrigger,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.resetNavigation()
        }
    }
}
