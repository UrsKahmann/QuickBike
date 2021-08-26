//
//  CoordinateUtils.swift
//  QuickBike
//
//  Created by Urs Privat on 26.08.21.
//

import Foundation
import MapKit

private enum Constants {
	static let regionSectionMultiplier: Double = 1
}

enum CoordinateUtils {
	static func coordinateRegion(for trafficLightRecordings: [TrafficLightRecording]) -> MKCoordinateRegion? {

		let latitudes = trafficLightRecordings.map { (recording: TrafficLightRecording) in
			return recording.coordinate.latitude
		}

		let longitudes = trafficLightRecordings.map { (recording: TrafficLightRecording) in
			return recording.coordinate.longitude
		}

		guard
			let maxLatitude = latitudes.max(),
			let maxLongitude = longitudes.max(),
			let minLatitude = latitudes.min(),
			let minLongitude = longitudes.min() else {
				return nil
		}

		let size = MKMapSize(
			width: (maxLatitude - minLatitude) + Constants.regionSectionMultiplier,
			height: (maxLongitude - minLongitude) + Constants.regionSectionMultiplier
		)

		let center = MKMapPoint(
			Coordinate(
				latitude: (minLatitude + maxLatitude) / 2,
				longitude: (minLongitude + maxLongitude) / 2
			)
		)

		let rect = MKMapRect(origin: center, size: size)

		return MKCoordinateRegion(rect)
	}
}
