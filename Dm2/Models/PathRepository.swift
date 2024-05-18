//  PathRepository.swift


import Foundation

class PathRepository {
    static let shared = PathRepository()

    private var paths: [Path]

    init() {
        paths = [
            Path(destinationName: "Garibaldi", beacons: ["Beacon1", "Beacon2", "Beacon3", "Beacon4"]),
            Path(destinationName: "Piscinola", beacons: ["Beacon1", "Beacon5", "Beacon6"]),
            Path(destinationName: "Mostra", beacons: ["Beacon1", "Beacon7", "Beacon8"]),
            Path(destinationName: "Margellina", beacons: ["Beacon1", "Beacon9"])
        ]
    }

    func findPath(by destinationName: String) -> Path? {
        return paths.first { $0.destinationName == destinationName }
    }
}
