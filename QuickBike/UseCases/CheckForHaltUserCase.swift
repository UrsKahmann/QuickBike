//
//  CheckForHaltUserCase.swift
//  QuickBike
//
//  Created by Urs Privat on 30.07.21.
//

import Foundation
import Combine

class CheckForHaltUseCase {

	private let locationRepository: LocationRepository
	private var motionDetector = MotionDetector()

	@Published var didHalt = false

	private var cancellable = Set<AnyCancellable>()

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository

		self.locationRepository
			.getLocations()
			.sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<Error>) in
				switch completion {
				case .finished: break
				case .failure(_):
					self?.didHalt = false
				}
			}, receiveValue: { (current: Coordinate) in
				self.didHalt = self.motionDetector.checkIfStanding(with: current)
			})
			.store(in: &cancellable)
	}
}
