//  LineModels.swift


import Foundation

struct Line: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stations: [String]
}
