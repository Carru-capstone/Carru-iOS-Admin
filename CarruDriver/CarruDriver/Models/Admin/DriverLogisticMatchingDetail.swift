//
//  DriverLogisticMatchingDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverLogisticMatchingDetail {
    let productId: Int
    let productName: String
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let departureName: String
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let price: Int
    let weight: Int
    let operationDistance: Int
    let operationTime: Int
    let deadLine: Date
    
    var title: String {
        return "출발: \(departureLocation)\n도착: \(destinationLocation)"
    }
    
    func toLogisticMapData() -> LogisticMapData {
        return .init(
            departureLocation: departureLocation,
            departureLatitude: departureLatitude,
            departureLongitude: departureLongitude,
            destinationLocation: destinationLocation,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude
        )
    }
}
