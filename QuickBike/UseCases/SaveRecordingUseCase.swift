//
//  SaveRecordingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import Combine

struct SaveRecordingUseCase {

	private let recordingRepository: RecordingRepository

	init(recordingRepository: RecordingRepository) {
		self.recordingRepository = recordingRepository
	}

	func add(recording: Recording) -> Error? {
		return self.recordingRepository.add(recording: recording)
	}
}
