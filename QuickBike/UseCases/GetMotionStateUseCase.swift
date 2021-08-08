//
//  GetMotionStateUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 30.07.21.
//

import Foundation
import Combine

enum MotionState {
	case standing
	case moving
	case unknown
}

class GetMotionStateUseCase {

	private let locationRepository: LocationRepository
	private var motionDetector = MotionDetector()
	private var sensitivity = MotionDetector.Constants.standingThreshold

	@Published var motionState: MotionState = .unknown

	private var cancellable = Set<AnyCancellable>()

	init(locationRepository: LocationRepository) {
		self.locationRepository = locationRepository

		self.locationRepository
			.getLocations()
			.sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<Error>) in
				switch completion {
				case .finished: break
				case .failure(_):
					self?.motionState = .unknown
				}
			}, receiveValue: { (current: Coordinate) in
				// Only update if the moving/standing state changed
				let isStanding = self.motionDetector.checkIfStanding(with: current, threshold: self.sensitivity)

				if isStanding && self.motionState != .standing {
					self.motionState = .standing
				} else if !isStanding && self.motionState != .moving {
					self.motionState = .moving
				}
			})
			.store(in: &cancellable)
	}

	func updateSensitivity(to sensitivity: Double) {
		self.sensitivity = sensitivity
	}
}
