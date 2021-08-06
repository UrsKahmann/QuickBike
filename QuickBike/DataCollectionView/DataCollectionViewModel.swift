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
	private let checkForHaltUseCase: CheckForHaltUseCase

	@Published var currentLocation: Coordinate?
	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var didStop: Bool = false

	private var cancellable = Set<AnyCancellable>()

	init(
		startUseCase: StartLocationTrackingUseCase,
		stopUseCase: StopLocationTrackingUseCase,
		getUseCase: GetLocationUseCase,
		haltUseCase: CheckForHaltUseCase) {

			self.startLocationTrackingUseCase = startUseCase
			self.stopLocationTrackingUseCase = stopUseCase
			self.getLocationDataUseCase = getUseCase
			self.checkForHaltUseCase = haltUseCase

			self.creatBindings()
	}

	private func creatBindings() {

		self.checkForHaltUseCase
			.$didHalt
			.sink { (didHalt: Bool) in
				self.didStop = didHalt
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
}
