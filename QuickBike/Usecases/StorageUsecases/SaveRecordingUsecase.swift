//
//  SaveRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import Combine

struct SaveRecordingUsecase {

	private let recordingRepository: RecordingRepository

	init(recordingRepository: RecordingRepository = RealRecordingRepository.shared) {
		self.recordingRepository = recordingRepository
	}

	func saveCurrentRecording() -> Error? {

		if TrafficLightRecorder.shared.finishRecording() != nil {
			return self.recordingRepository.save()
		}

		return nil
	}
}
