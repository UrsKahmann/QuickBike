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

	private let startLocationTrackingUsecase: StartLocationTrackingUsecase
	private let stopLocationTrackingUsecase: StopLocationTrackingUsecase
	private let getLocationDataUsecase: GetLocationUsecase
	private let getMotionStateUsecase: GetMotionStateUsecase
	private let saveRecordingUsecase: SaveRecordingUsecase
	private let startRecordingUsecase: StartRecordingUsecase
	private let startTrafficLightRecoringUsecase: StartTrafficLightRecordingUsecase
	private let stopTrafficLightRecordingUsecase: StopTrafficLightRecordingUsecase

	@Published var currentLocation: Coordinate?
	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var motionState: MotionState = .unknown
	@Published var showAlert: Bool = false
	@Published var recordingSavingError: Error?
	@Published var recordingStartError: Bool = false

	var currentAlert: AlertType = .stop
	var userConfirmedTrafficLight = false

	var motionDetectionSensitivity: Double = MotionDetector.Constants.standingThreshold

	private var cancellable = Set<AnyCancellable>()

	init(
		startUsecase: StartLocationTrackingUsecase,
		stopUsecase: StopLocationTrackingUsecase,
		getUsecase: GetLocationUsecase,
		haltUsecase: GetMotionStateUsecase,
		saveRecordingUsecase: SaveRecordingUsecase,
		startRecordingUsecase: StartRecordingUsecase,
		startTrafficUsecase: StartTrafficLightRecordingUsecase,
		stopTrafficUsecase: StopTrafficLightRecordingUsecase) {

			self.startLocationTrackingUsecase = startUsecase
			self.stopLocationTrackingUsecase = stopUsecase
			self.getLocationDataUsecase = getUsecase
			self.getMotionStateUsecase = haltUsecase
			self.saveRecordingUsecase = saveRecordingUsecase
			self.startRecordingUsecase = startRecordingUsecase
			self.startTrafficLightRecoringUsecase = startTrafficUsecase
			self.stopTrafficLightRecordingUsecase = stopTrafficUsecase

			self.creatBindings()
	}

	private func creatBindings() {

		self.getMotionStateUsecase
			.$motionState
			.sink { (motionState: MotionState) in
				self.motionState = motionState

				if self.motionState == .standing {
					self.currentAlert = .stop
					self.showAlert = true
					print("Did Stop = true")
					if let currentLocation = self.currentLocation {
						self.startTrafficLightRecoringUsecase
							.start(coordinate: currentLocation)
					}

				} else {
					self.showAlert = false
					print("Did Stop = false")
					if self.userConfirmedTrafficLight == true {
						self.userConfirmedTrafficLight = false
						self.stopTrafficLightRecordingUsecase.stop()
					} else {
						// TODO: cancel traffic light recordin
					}
				}
			}
			.store(in: &cancellable)

		self.getLocationDataUsecase
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
		self.startLocationTrackingUsecase.start()
	}

	func stopLocationTracking() {
		self.stopLocationTrackingUsecase.stop()
	}

	func sensitivityChanged() {
		self.getMotionStateUsecase.updateSensitivity(to: self.motionDetectionSensitivity)
	}

	func startRecording() {
		// If the recording couldn't be started, false is returned
		self.recordingStartError = self.startRecordingUsecase.start() == false
	}

	func stopRecording() {
		self.recordingSavingError = self.saveRecordingUsecase.saveCurrentRecording()
	}

	func confirmTrafficLight() {
		self.userConfirmedTrafficLight = true
	}
}
