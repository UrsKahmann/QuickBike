//
//  GetRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import Combine

class GetRecordingUsecase {

	private let recordingRepository: RecordingRepository

	private var cancellable = Set<AnyCancellable>()

	@Published var recordings: [Recording] = []
	@Published var error: Error?

	init(recordingRepository: RecordingRepository = RealRecordingRepository.shared) {
		self.recordingRepository = recordingRepository

		self.recordingRepository
			.recordings
			.sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<Error>) in
				  switch completion {
				  case .finished: break
				  case .failure(let error):
					self?.error = error
				  }
			}, receiveValue: { (recordings: [Recording]) in
					self.recordings = recordings
			})
			.store(in: &cancellable)
	}

	func getAllRecordings() {
		self.recordingRepository.getAll()
	}
}
