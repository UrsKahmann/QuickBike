//
//  CoordinateUtils.swift
//  QuickBike
//
//  Created by Urs Privat on 26.08.21.
//

import Foundation
import MapKit

enum CoordinateUtils {
	static func coordinateRegion(for trafficLightRecordings: [RecordingPoint]) -> MKCoordinateRegion? {

		let latitudes = trafficLightRecordings.map { (recording: RecordingPoint) in
			return recording.coordinate.latitude
		}

		let longitudes = trafficLightRecordings.map { (recording: RecordingPoint) in
			return recording.coordinate.longitude
		}

		guard
			let maxLatitude = latitudes.max(),
			let maxLongitude = longitudes.max(),
			let minLatitude = latitudes.min(),
			let minLongitude = longitudes.min() else {
				return nil
		}

		let latMaxCoordinate = CLLocation(latitude: maxLatitude, longitude: 0.0)
		let latMinCoordinate = CLLocation(latitude: minLatitude, longitude: 0.0)

		let longMaxCoordinate = CLLocation(latitude: 0.0, longitude: maxLongitude)
		let longMinCoordinate = CLLocation(latitude: 0.0, longitude: minLongitude)

		let latitudinalMeters =  latMaxCoordinate.distance(from: latMinCoordinate)
		let longitudinalMeters = longMaxCoordinate.distance(from: longMinCoordinate)

		let center = Coordinate(
			latitude: (minLatitude + maxLatitude) / 2,
			longitude: (minLongitude + maxLongitude) / 2
		)

		return MKCoordinateRegion(
			center: center,
			latitudinalMeters: latitudinalMeters,
			longitudinalMeters: longitudinalMeters
		)
	}
}
