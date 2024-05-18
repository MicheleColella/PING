//
//  Waypoint.swift
//  Dm2
//
//  Created by Salvatore Attanasio on 18/05/24.
//

import Foundation
import CoreLocation

struct Waypoint{
    let id = UUID()
    let beacon : CLBeacon
    var distance : Double{
        return beacon.accuracy
    }
}
