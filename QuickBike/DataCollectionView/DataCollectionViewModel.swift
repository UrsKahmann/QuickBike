//
//  DataCollectionViewModel.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class DataCollectionViewModel: ObservableObject {

	private let startLocationTrackingUseCase: StartLocationTrackingUseCase
	private let stopLocationTrackingUseCase: StopLocationTrackingUseCase
	private let getLocationDataUseCase: GetLocationUseCase
	private let getMotionStateUseCase: GetMotionStateUseCase

	@Published var currentLocation: Coordinate?
	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var motionState: MotionState = .unknown
	@Published var didStop: Bool = false

	var motionDetectionSensitivity: Double = MotionDetector.Constants.standingThreshold

	private var cancellable = Set<AnyCancellable>()

	init(
		startUseCase: StartLocationTrackingUseCase,
		stopUseCase: StopLocationTrackingUseCase,
		getUseCase: GetLocationUseCase,
		haltUseCase: GetMotionStateUseCase) {

			self.startLocationTrackingUseCase = startUseCase
			self.stopLocationTrackingUseCase = stopUseCase
			self.getLocationDataUseCase = getUseCase
			self.getMotionStateUseCase = haltUseCase

			self.creatBindings()
	}

	private func creatBindings() {

		self.getMotionStateUseCase
			.$motionState
			.sink { (motionState: MotionState) in
				self.motionState = motionState
				print("Motion State changed to: \(self.motionState)")
				if self.motionState == .standing {
					self.didStop = true
				} else {
					self.didStop = false
				}
			}
			.store(in: &cancellable)
		self.getLocationDataUseCase
			.$currentLocation
			.sink { (current: Coordinate) in

				self.currentLocation = current

				let center = Coordinate(
					latitude: current.latitude,
					longitude: current.longitude
				)

				let span = MKCoordinateSpan(
					latitudeDelta: 0.005,
					longitudeDelta: 0.005
				)

				self.region = MKCoordinateRegion(center: center, span: span)
			}
			.store(in: &cancellable)
	}

	func annontationItems() -> [Coordinate] {
		if let current = self.currentLocation {
			return [current]
		}

		return []
	}

	func startLocationTracking() {
		self.startLocationTrackingUseCase.start()
	}

	func stopLocationTracking() {
		self.stopLocationTrackingUseCase.stop()
	}

	func sensitivityChanged() {
		self.getMotionStateUseCase.updateSensitivity(to: self.motionDetectionSensitivity)
	}
}
