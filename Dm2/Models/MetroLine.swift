//
//  MetroLine.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 18/05/24.
//

import Foundation

struct MetroLine {
    let name: String
    let stations: [Station]
    
    var directionA : String{
        return self.stations.first?.name ?? "NO_NAME"
    }
    
    var directionB : String{
        return self.stations.last?.name ?? "NO_NAME"
    }
}
