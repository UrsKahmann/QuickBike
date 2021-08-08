//
//  ViewModelFactory.swift
//  QuickBike
//
//  Created by Urs Privat on 28.07.21.
//

import Foundation

struct ViewModelFactory {
	static let shared = ViewModelFactory()

	private let locationProvider = MockLocationService()

	// Init repostiories
	private let locationRepository: LocationRepository

	// Use Cases
	private let startLocationTrackingUseCase: StartLocationTrackingUseCase
	private let stopLocationTrackingUseCase: StopLocationTrackingUseCase
	private let getLocationDataUseCase: GetLocationUseCase
	private let checkForHaltUseCase: GetMotionStateUseCase

	// ViewModels
	let dataCollectionViewModel: DataCollectionViewModel

	init() {
		// Init repostiories
		self.locationRepository = RealLocationRepository(locationProvider: self.locationProvider)

		self.startLocationTrackingUseCase = StartLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.stopLocationTrackingUseCase = StopLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.getLocationDataUseCase = GetLocationUseCase(locationRepository: self.locationRepository)
		self.checkForHaltUseCase = GetMotionStateUseCase(locationRepository: self.locationRepository)

		self.dataCollectionViewModel = DataCollectionViewModel(
			startUseCase: self.startLocationTrackingUseCase,
			stopUseCase: self.stopLocationTrackingUseCase,
			getUseCase: self.getLocationDataUseCase,
			haltUseCase: self.checkForHaltUseCase)
	}
}
