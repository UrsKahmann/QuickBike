//
//  RecordingHistoryView.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import SwiftUI
import Rswift

struct RecordingHistoryView: View {

	@ObservedObject var viewModel = ViewModelFactory.shared.recordingHistoryViewModel

	var body: some View {
		NavigationView {
			VStack {
				if self.viewModel.recordings.isEmpty {
					Text(R.string.localizable.recordingHistoryListEmpty())
				} else if let error = self.viewModel.error {
					Text(error.localizedDescription)
				} else {
					List(self.viewModel.recordings) { record in
						Text("Record with \(record.data.count) traffic lights")
					}
				}
			}
			.navigationBarTitle(
				Text(R.string.localizable.recordingHistoryListTitle())
			)
		}
		.onAppear {
			self.viewModel.getAllRecordings()
		}
	}
}

struct RecordingHistoryView_Previews: PreviewProvider {
	static var previews: some View {
		RecordingHistoryView()
	}
}
