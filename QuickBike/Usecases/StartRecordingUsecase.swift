//
//  StartRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 08.08.21.
//

import Foundation

struct StartRecordingUsecase {
	private let recordingRepository: RecordingRepository

	init(recordingRepository: RecordingRepository = RealRecordingRepository.shared) {
		self.recordingRepository = recordingRepository
	}

	// Returns wether the recording could be started successfully
	func start() -> Bool {
		if let context = self.recordingRepository.context {
			TrafficLightRecorder.shared.startRecording(in: context)
			return true
		}

		return false
	}
}
