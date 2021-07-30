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
	@Published var locationError: Error?

	private var cancellable = Set<AnyCancellable>()

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository

		self.locationRepository
			.getLocations()
			.sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<Error>) in
				switch completion {
				case .finished: break
				case .failure(let error):
					self?.locationError = error
				}
			}, receiveValue: { (current: UserCoordinate) in
				print("Received location update: \(current.latitude),  \(current.longitude)")
				self.currentLocation = current
			})
			.store(in: &cancellable)
	}
}
