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
	private let recordingRepository = RealRecordingRepository()

	// Use Cases
	private let startLocationTrackingUseCase: StartLocationTrackingUseCase
	private let stopLocationTrackingUseCase: StopLocationTrackingUseCase
	private let getLocationDataUseCase: GetLocationUseCase
	private let checkForHaltUseCase: GetMotionStateUseCase
	private let saveRecordingUseCase: SaveRecordingUseCase
	private let getRecordingUseCase: GetRecordingUseCase
	private let startRecordingUseCase: StartRecordingUseCase
	private let startTrafficLightRecordingUseCase = StartTrafficLightRecordingUseCase()
	private let stopTrafficLightRecordingUseCase = StopTrafficLightRecordingUseCase()
	private let deleteRecordingUseCase: DeleteRecordingUseCase

	// ViewModels
	let dataCollectionViewModel: DataCollectionViewModel
	let recordingHistoryViewModel: RecordingHistoryViewModel
	let recordingHistoryDetailViewModel: RecordingHistoryDetailViewModel

	init() {
		// Init repostiories
		self.locationRepository = RealLocationRepository(locationProvider: self.locationProvider)

		self.startLocationTrackingUseCase = StartLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.stopLocationTrackingUseCase = StopLocationTrackingUseCase(locationRepository: self.locationRepository)
		self.getLocationDataUseCase = GetLocationUseCase(locationRepository: self.locationRepository)
		self.checkForHaltUseCase = GetMotionStateUseCase(locationRepository: self.locationRepository)
		self.saveRecordingUseCase = SaveRecordingUseCase(recordingRepository: self.recordingRepository)
		self.getRecordingUseCase = GetRecordingUseCase(recordingRepository: self.recordingRepository)
		self.startRecordingUseCase = StartRecordingUseCase(recordingRepository: self.recordingRepository)
		self.deleteRecordingUseCase = DeleteRecordingUseCase(recordingRepository: self.recordingRepository)

		self.dataCollectionViewModel = DataCollectionViewModel(
			startUseCase: self.startLocationTrackingUseCase,
			stopUseCase: self.stopLocationTrackingUseCase,
			getUseCase: self.getLocationDataUseCase,
			haltUseCase: self.checkForHaltUseCase,
			saveRecordingUseCase: self.saveRecordingUseCase,
			startRecordingUseCase: self.startRecordingUseCase,
			startTrafficUseCase: self.startTrafficLightRecordingUseCase,
			stopTrafficUseCase: self.stopTrafficLightRecordingUseCase
		)

		self.recordingHistoryViewModel = RecordingHistoryViewModel(
			getRecordingUseCase: self.getRecordingUseCase,
			deleteRecordingUseCase: self.deleteRecordingUseCase
		)

		self.recordingHistoryDetailViewModel = RecordingHistoryDetailViewModel(
			getRecordingUseCase: self.getRecordingUseCase
		)
	}
}
