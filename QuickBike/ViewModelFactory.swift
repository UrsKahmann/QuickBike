//
//  ViewModelFactory.swift
//  QuickBike
//
//  Created by Urs Privat on 28.07.21.
//

import Foundation

struct ViewModelFactory {

	static func createDataCollectionViewModel() -> DataCollectionViewModel {
		return DataCollectionViewModel(
			startUsecase: StartLocationTrackingUsecase(),
			stopUsecase: StopLocationTrackingUsecase(),
			getUsecase: GetLocationUsecase(),
			haltUsecase: GetMotionStateUsecase(),
			saveRecordingUsecase: SaveRecordingUsecase(),
			startRecordingUsecase: StartRecordingUsecase(),
			startTrafficUsecase: StartTrafficLightRecordingUsecase(),
			stopTrafficUsecase: StopTrafficLightRecordingUsecase()
		)
	}

	static func createRecordingHistoryViewModel() -> RecordingHistoryViewModel {
		return RecordingHistoryViewModel(
			getRecordingUsecase: GetRecordingUsecase(),
			deleteRecordingUsecase: DeleteRecordingUsecase()
		)
	}

	static func createRecordingHistoryDetailViewModel() -> RecordingHistoryDetailViewModel {
		return RecordingHistoryDetailViewModel(
			getRecordingUsecase: GetRecordingUsecase()
		)
	}
}
