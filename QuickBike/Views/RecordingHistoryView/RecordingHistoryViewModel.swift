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

	private let getRecordingUseCase: GetRecordingUseCase

	@Published var recordings: [Recording] = []
	@Published var error: Error?

	private var cancellable = Set<AnyCancellable>()

	init(getRecordingUseCase: GetRecordingUseCase) {
		self.getRecordingUseCase = getRecordingUseCase

		self.getRecordingUseCase
			.$recordings
			.sink { recordings in
				self.recordings = recordings
			}
			.store(in: &cancellable)

		self.getRecordingUseCase
			.$error
			.sink { error in
				self.error = error
			}
			.store(in: &cancellable)

		self.getAllRecordings()
	}

	func getAllRecordings() {
		self.getRecordingUseCase.getAllRecordings()
	}
}
