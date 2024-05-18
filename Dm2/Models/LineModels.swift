//  LineModels.swift
//  Dm2
//
//  Created by Michele Colella on 18/05/24.
//

import Foundation

struct Line: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stations: [String]
}
