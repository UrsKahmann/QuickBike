//
//  DeleteRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 25.08.21.
//

import Foundation

struct DeleteRecordingUsecase {

	private let recordingRepository: RecordingRepository

	init(recordingRepository: RecordingRepository = RealRecordingRepository.shared) {
		self.recordingRepository = recordingRepository
	}

	func delete(recording: Recording) {
		self.recordingRepository.delete(recording: recording)
	}
}
