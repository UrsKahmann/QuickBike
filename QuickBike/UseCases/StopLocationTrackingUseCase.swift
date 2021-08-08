//
//  StopLocationTrackingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 27.07.21.
//

import Foundation

struct StopLocationTrackingUseCase {

	private let locationRepository: LocationRepository

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository
	}

	func stop() {
		self.locationRepository.stopLocationTracking()
	}
}
