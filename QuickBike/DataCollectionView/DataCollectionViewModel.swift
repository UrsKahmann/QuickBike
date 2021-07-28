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

	@Published var currentLocation: UserCoordinate?
	@Published var region: MKCoordinateRegion = MKCoordinateRegion()

	private var cancallable = Set<AnyCancellable>()

	init(
		startUseCase: StartLocationTrackingUseCase,
		stopUseCase: StopLocationTrackingUseCase,
		getUseCase: GetLocationUseCase) {

			self.startLocationTrackingUseCase = startUseCase
			self.stopLocationTrackingUseCase = stopUseCase
			self.getLocationDataUseCase = getUseCase

			self.getLocationDataUseCase
				.$currentLocation
				.sink(receiveValue: { (current: UserCoordinate) in

					self.currentLocation = current

					let center = CLLocationCoordinate2D(
						latitude: current.latitude,
						longitude: current.longitude
					)

					let span = MKCoordinateSpan(
						latitudeDelta: 0.005,
						longitudeDelta: 0.005
					)

					self.region = MKCoordinateRegion(center: center, span: span)
				})
				.store(in: &cancallable)
	}

	func annontationItems() -> [UserCoordinate] {
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
