//
//  StopLocationTrackingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 27.07.21.
//

import Foundation

struct StopLocationTrackingUsecase {

	private let locationRepository: LocationRepository

	init(locationRepository: LocationRepository = RealLocationRepository.shared) {
		self.locationRepository = locationRepository
	}

	func stop() {
		self.locationRepository.stopLocationTracking()
	}
}
