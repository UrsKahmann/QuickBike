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
	func getLocations() -> AnyPublisher<UserCoordinate, Error>
}

struct RealLocationRepository: LocationRepository {

	private let locationService: LocationProvider

	init(locationProvider: LocationProvider = LocationService()) {
		self.locationService = locationProvider
	}

	func startLocationTracking() {
		self.locationService.startLocationTracking()
	}

	func stopLocationTracking() {
		self.locationService.stopLocationTracking()
	}

	func getLocations() -> AnyPublisher<UserCoordinate, Error> {
		return self.locationService
			.location
			.compactMap { (location: CLLocation) -> UserCoordinate in
				return UserCoordinate(
					latitude: location.coordinate.latitude,
					longitude: location.coordinate.longitude
				)
			}
			.eraseToAnyPublisher()
	}
}
