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
					List {
						ForEach(self.viewModel.recordings, id: \.self) { record in
							NavigationLink(
								destination: RecordingHistoryDetailView(recordingID: record.id),
//								destination: Text("Record with \(record.data?.count ?? 0) traffic lights"),
								label: {
									Text("Record with \(record.data?.count ?? 0) traffic lights")
								})

						}
						.onDelete(perform: self.viewModel.delete)
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
