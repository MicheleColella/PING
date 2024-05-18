//
//  RouteManager.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 18/05/24.
//

import Foundation

class RouteManager{
    func getRoute(from stationName: String, to destination: String) -> Route?{
        guard let routes = RouteManager.allRoutes[stationName] else {
            return nil
        }
        
        return routes.first { $0.destination == destination }
    }
}

extension RouteManager{
    private static let allRoutes : [String: [Route]] = [
        "Municipio" : [
            Route(destination: "Linea1", waypoints: []),
            Route(destination: "Linea6", waypoints: []),
        ]
    ]
}
