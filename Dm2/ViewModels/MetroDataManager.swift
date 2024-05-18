//
//  MetroDataManager.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 18/05/24.
//

import Foundation

class MetroDataManager {
    private let lines: [MetroLine] = [
        MetroDataManager.linea1,
        MetroDataManager.linea6,
    ]

    func getStations(forLine lineName: String) -> [Station]? {
        return lines.first { $0.name == lineName }?.stations
    }
}

extension MetroDataManager{
    static private let linea1 = MetroLine(name: "Linea 1", stations: [
        Station(name: "Garibaldi",      connectedLines: ["Linea 1"]),
        Station(name: "Duomo",          connectedLines: ["Linea 1"]),
        Station(name: "Università",     connectedLines: ["Linea 1"]),
        Station(name: "Municipio",      connectedLines: ["Linea 1", "Linea 6"]),
        Station(name: "Dante",          connectedLines: ["Linea 1"]),
        Station(name: "Museo",          connectedLines: ["Linea 1"]),
        Station(name: "Materdei",       connectedLines: ["Linea 1"]),
        Station(name: "Salvator Rosa",  connectedLines: ["Linea 1"]),
        Station(name: "Quattro Giornate",connectedLines: ["Linea 1"]),
        Station(name: "Vanvitelli",     connectedLines: ["Linea 1"]),
        Station(name: "Medaglie D'Oro", connectedLines: ["Linea 1"]),
        Station(name: "Montedonzelli",  connectedLines: ["Linea 1"]),
        Station(name: "Rione Alto",     connectedLines: ["Linea 1"]),
        Station(name: "Policlinico",    connectedLines: ["Linea 1"]),
        Station(name: "Colli Aminei",   connectedLines: ["Linea 1"]),
        Station(name: "Frullone",       connectedLines: ["Linea 1"]),
        Station(name: "Chiaiano",       connectedLines: ["Linea 1"]),
        Station(name: "Piscinola",      connectedLines: ["Linea 1"]),
    ])
    
    static private let linea6 = MetroLine(name: "linea 6", stations: [
        Station(name: "Porto",          connectedLines: ["Linea 6", "Linea 1"]),
        Station(name: "Chiaia",         connectedLines: ["Linea 6"]),
        Station(name: "San Pasquale",   connectedLines: ["Linea 6"]),
        Station(name: "Arco Mirelli",   connectedLines: ["Linea 6"]),
        Station(name: "Mergellina",     connectedLines: ["Linea 6"]),
        Station(name: "Lala",           connectedLines: ["Linea 6"]),
        Station(name: "Augusto",        connectedLines: ["Linea 6"]),
        Station(name: "Mostra",         connectedLines: ["Linea 6"]),
    ])
}
