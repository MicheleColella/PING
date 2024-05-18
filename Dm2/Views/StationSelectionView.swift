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
            )
            .onChange(of: viewModel.selectedStation) { _ in
                viewModel.navigationTrigger = true
            }
            .onDisappear {
                // Controlla se la navigazione è stata completata o se l'utente sta semplicemente andando indietro.
                if viewModel.navigationTrigger && viewModel.selectedStation == nil {
                    // Se la navigazione al percorso non è ancora avvenuta, non resettare.
                    // Oppure, se la navigazione al percorso è già stata fatta e l'utente sta andando indietro,
                    // allora resetta.
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
            viewModel.resetNavigation() // Resetta il trigger quando appare questa vista
        }
    }
}
