//
//  DeleteRecordingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 25.08.21.
//

import Foundation

struct DeleteRecordingUseCase {

	private let recordingRepository: RecordingRepository

	init(recordingRepository: RecordingRepository) {
		self.recordingRepository = recordingRepository
	}

	func delete(recording: Recording) {
		self.recordingRepository.delete(recording: recording)
	}
}
