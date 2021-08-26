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

	private let getRecordingUseCase: GetRecordingUseCase

	var recordingID: UUID?

	var trafficLightRecordings: [TrafficLightRecording] {
		if let recordings = self.recording?.data?.array as? [TrafficLightRecording] {
			return recordings
		}

		return []
	}

	@Published var region: MKCoordinateRegion = MKCoordinateRegion()
	@Published var recording: Recording?
	@Published var error: Error?

	private var cancellable = Set<AnyCancellable>()

	init(
		getRecordingUseCase: GetRecordingUseCase,
		for recordingID: UUID? = nil
	) {

		self.getRecordingUseCase = getRecordingUseCase

		self.getRecordingUseCase
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

		self.getRecordingUseCase
			.$error
			.sink { error in
				self.error = error
			}
			.store(in: &cancellable)

		self.getAllRecordings()
	}

	func annontationItems() -> [Coordinate] {
		let trafficLightCoordinate = self.trafficLightRecordings.map { (recording: TrafficLightRecording) in
			recording.coordinate
		}

		return trafficLightCoordinate
	}

	func getAllRecordings() {
		self.getRecordingUseCase.getAllRecordings()
	}
}
