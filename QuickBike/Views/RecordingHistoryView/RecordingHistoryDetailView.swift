//
//  RecordingHistoryDetailView.swift
//  QuickBike
//
//  Created by Urs Privat on 26.08.21.
//

import SwiftUI
import MapKit

struct RecordingHistoryDetailView: View {

	@ObservedObject var viewModel = ViewModelFactory.createRecordingHistoryDetailViewModel()

	init(recordingID: UUID?) {
		self.viewModel.recordingID = recordingID
	}

	var body: some View {
		VStack {
			if self.viewModel.recording == nil {
				Text("Error loading data")
			} else if let error = self.viewModel.error {
				Text(error.localizedDescription)
			} else {
				Map(coordinateRegion: self.$viewModel.region, annotationItems: self.viewModel.annontationItems()) {
					MapPin(
						coordinate: Coordinate(latitude: $0.latitude, longitude: $0.longitude),
						tint: .red)
				}
			}
		}
		.onAppear {
			self.viewModel.getAllRecordings()
		}
		.navigationBarTitleDisplayMode(.inline)
	}
}
