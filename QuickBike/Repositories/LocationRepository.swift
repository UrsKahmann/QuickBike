//
//  LocationRepository.swift
//  QuickBike
//
//  Created by Urs Privat on 26.07.21.
//

import Foundation
import Combine
import CoreLocation

protocol LocationRepository {
	func startLocationTracking()
	func stopLocationTracking()
	func getLocations() -> AnyPublisher<Coordinate, Error>
}

struct RealLocationRepository: LocationRepository {

	static let shared = RealLocationRepository()

	private let locationService: LocationProvider = MockLocationService() // LocationService()

	private init() {}

	func startLocationTracking() {
		self.locationService.startLocationTracking()
	}

	func stopLocationTracking() {
		self.locationService.stopLocationTracking()
	}

	func getLocations() -> AnyPublisher<Coordinate, Error> {
		return self.locationService
			.location
			.compactMap { (location: CLLocation) -> Coordinate in
				return Coordinate(
					latitude: location.coordinate.latitude,
					longitude: location.coordinate.longitude
				)
			}
			.eraseToAnyPublisher()
	}
}
