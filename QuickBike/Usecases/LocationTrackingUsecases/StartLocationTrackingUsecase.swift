//
//  StartLocationTrackingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 26.07.21.
//

import Foundation

struct StartLocationTrackingUsecase {

	private let locationRepository: LocationRepository

	init(locationRepository: LocationRepository = RealLocationRepository.shared) {
		self.locationRepository = locationRepository
	}

	func start() {
		self.locationRepository.startLocationTracking()
	}
}
