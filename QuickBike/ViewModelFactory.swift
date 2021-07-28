//
//  ViewModelFactory.swift
//  QuickBike
//
//  Created by Urs Privat on 28.07.21.
//

import Foundation

struct ViewModelFactory {
	static let shared = ViewModelFactory()

	// Init repostiories
	private let locationRepository = TestLocationRepository() //RealLocationRepository()

	// Use Cases
	private let startLocationTrackingUseCase: StartLocationTrackingUseCase
	private let stopLocationTrackingUseCase: StopLocationTrackingUseCase
	private let getLocationDataUseCase: GetLocationUseCase

	// ViewModels
	let dataCollectionViewModel: DataCollectionViewModel

	init() {
		self.startLocationTrackingUseCase = StartLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.stopLocationTrackingUseCase = StopLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.getLocationDataUseCase = GetLocationUseCase(locationRepository: self.locationRepository)

		self.dataCollectionViewModel = DataCollectionViewModel(
			startUseCase: self.startLocationTrackingUseCase,
			stopUseCase: self.stopLocationTrackingUseCase,
			getUseCase: self.getLocationDataUseCase)
	}
}
