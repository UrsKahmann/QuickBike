//
//  GetLocationUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 27.07.21.
//

import Foundation
import Combine

class GetLocationUseCase {

	private let locationRepository: LocationRepository

	@Published var currentLocation: UserCoordinate = UserCoordinate(latitude: 0, longitude: 0)

	private var cancallable = Set<AnyCancellable>()

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository

		self.locationRepository
			.getLocations()
			.sink(receiveValue: { (current: UserCoordinate) in
				print("Received location update: \(current.latitude),  \(current.longitude)")
				self.currentLocation = current
			})
			.store(in: &cancallable)
	}
}
