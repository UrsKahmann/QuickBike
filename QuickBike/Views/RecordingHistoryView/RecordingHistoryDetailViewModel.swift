//
//  RecordingHistoryDetailViewModel.swift
//  QuickBike
//
//  Created by Urs Privat on 26.08.21.
//

import Foundation
import Combine
import MapKit

class RecordingHistoryDetailViewModel: ObservableObject {

	private let getRecordingUsecase: GetRecordingUsecase

	var recordingID: UUID?

	var trafficLightRecordings: [RecordingPoint] {
		if let recordings = self.recording?.data?.array as? [RecordingPoint] {
			return recordings
		}

		return []
	}

	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var recording: Recording?
	@Published var error: Error?

	private var cancellable = Set<AnyCancellable>()

	init(
		getRecordingUsecase: GetRecordingUsecase,
		for recordingID: UUID? = nil
	) {

		self.getRecordingUsecase = getRecordingUsecase

		self.getRecordingUsecase
			.$recordings
			.sink { (recordings: [Recording]) in
				self.recording = recordings.filter { (recording: Recording) in
					return recording.id == self.recordingID
				}.first

				if let coordinateRegion = CoordinateUtils.coordinateRegion(for: self.trafficLightRecordings) {
					self.region = coordinateRegion
				}
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

	func annontationItems() -> [Coordinate] {
		let trafficLightCoordinate = self.trafficLightRecordings.map { (recording: RecordingPoint) in
			recording.coordinate
		}

		return trafficLightCoordinate
	}

	func getAllRecordings() {
		self.getRecordingUsecase.getAllRecordings()
	}
}
