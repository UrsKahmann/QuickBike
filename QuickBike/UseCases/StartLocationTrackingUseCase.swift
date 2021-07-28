//
//  StartLocationTrackingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 26.07.21.
//

import Foundation

class StartLocationTrackingUseCase {

	private let locationRepository: LocationRepository

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository
	}

	func start() {
		self.locationRepository.startLocationTracking()
	}
}
