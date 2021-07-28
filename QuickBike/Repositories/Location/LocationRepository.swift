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
	func getLocations() -> AnyPublisher<UserCoordinate, Never>
}

struct RealLocationRepository: LocationRepository {

	private let locationService: LocationService = LocationService()

	func startLocationTracking() {
		self.locationService.startLocationDataCollection()
	}

	func stopLocationTracking() {
		self.locationService.stopLocationDataCollection()
	}

	func getLocations() -> AnyPublisher<UserCoordinate, Never> {
		return self.locationService
			.$location
			.map { (location: CLLocation?) -> UserCoordinate in
				guard let location = location else {
					return UserCoordinate(latitude: 0, longitude: 0)
				}

				return UserCoordinate(
					latitude: location.coordinate.latitude,
					longitude: location.coordinate.longitude
				)
			}
			.eraseToAnyPublisher()
	}
}
