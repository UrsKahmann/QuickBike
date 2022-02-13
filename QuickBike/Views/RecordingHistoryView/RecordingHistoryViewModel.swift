//
//  RecordingHistoryViewModel.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class RecordingHistoryViewModel: ObservableObject {

	private let getRecordingUsecase: GetRecordingUsecase
	private let deleteRecordingUsecase: DeleteRecordingUsecase

	@Published var recordings: [Recording] = []
	@Published var error: Error?

	private var cancellable = Set<AnyCancellable>()

	init(
		getRecordingUsecase: GetRecordingUsecase,
		deleteRecordingUsecase: DeleteRecordingUsecase
	) {

		self.getRecordingUsecase = getRecordingUsecase
		self.deleteRecordingUsecase = deleteRecordingUsecase

		self.getRecordingUsecase
			.$recordings
			.sink { recordings in
				self.recordings = recordings
			}
			.store(in: &cancellable)

		self.getRecordingUsecase
			.$error
			.sink { error in
				self.error = error
			}
			.store(in: &cancellable)

		self.getAllRecordings()
	}

	func getAllRecordings() {
		self.getRecordingUsecase.getAllRecordings()
	}

	func delete(at indexOffset: IndexSet) {
		let recordingsToDelete = indexOffset.map { index in
			self.recordings[index]
		}

		for recording in recordingsToDelete {
			print("Deleting a recording")
			self.deleteRecordingUsecase.delete(recording: recording)
		}

		self.getAllRecordings()
	}
}
