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

enum AlertType {
	case stop
	case recordingSavingError
}

class DataCollectionViewModel: ObservableObject {

	private let startLocationTrackingUseCase: StartLocationTrackingUseCase
	private let stopLocationTrackingUseCase: StopLocationTrackingUseCase
	private let getLocationDataUseCase: GetLocationUseCase
	private let getMotionStateUseCase: GetMotionStateUseCase
	private let saveRecordingUseCase: SaveRecordingUseCase
	private let startRecordingUseCase: StartRecordingUseCase
	private let startTrafficLightRecoringUseCase: StartTrafficLightRecordingUseCase
	private let stopTrafficLightRecordingUseCase: StopTrafficLightRecordingUseCase

	@Published var currentLocation: Coordinate?
	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var motionState: MotionState = .unknown
	@Published var showAlert: Bool = false
	@Published var recordingSavingError: Error?

	var currentAlert: AlertType = .stop
	var userConfirmedTrafficLight = false

	var motionDetectionSensitivity: Double = MotionDetector.Constants.standingThreshold

	private var cancellable = Set<AnyCancellable>()

	init(
		startUseCase: StartLocationTrackingUseCase,
		stopUseCase: StopLocationTrackingUseCase,
		getUseCase: GetLocationUseCase,
		haltUseCase: GetMotionStateUseCase,
		saveRecordingUseCase: SaveRecordingUseCase,
		startRecordingUseCase: StartRecordingUseCase,
		startTrafficUseCase: StartTrafficLightRecordingUseCase,
		stopTrafficUseCase: StopTrafficLightRecordingUseCase) {

			self.startLocationTrackingUseCase = startUseCase
			self.stopLocationTrackingUseCase = stopUseCase
			self.getLocationDataUseCase = getUseCase
			self.getMotionStateUseCase = haltUseCase
			self.saveRecordingUseCase = saveRecordingUseCase
			self.startRecordingUseCase = startRecordingUseCase
			self.startTrafficLightRecoringUseCase = startTrafficUseCase
			self.stopTrafficLightRecordingUseCase = stopTrafficUseCase

			self.creatBindings()
	}

	private func creatBindings() {

		self.getMotionStateUseCase
			.$motionState
			.sink { (motionState: MotionState) in
				self.motionState = motionState

				if self.motionState == .standing {
					self.currentAlert = .stop
					self.showAlert = true
					print("Did Stop = true")
					if let currentLocation = self.currentLocation {
						self.startTrafficLightRecoringUseCase
							.start(coordinate: currentLocation)
					}

				} else {
					self.showAlert = false
					print("Did Stop = false")
					if self.userConfirmedTrafficLight == true {
						self.userConfirmedTrafficLight = false
						self.stopTrafficLightRecordingUseCase.stop()
					} else {
						// TODO: cancel traffic light recordin
					}
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

		self.$recordingSavingError
			.sink { error in
				if error != nil {
					self.currentAlert = .recordingSavingError
					self.showAlert = true
				}
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

	func startRecording() {
		self.startRecordingUseCase.start()
	}

	func stopRecording() {
		self.recordingSavingError = self.saveRecordingUseCase.saveCurrentRecording()
	}

	func confirmTrafficLight() {
		self.userConfirmedTrafficLight = true
	}
}
