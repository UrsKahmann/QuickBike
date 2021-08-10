//
//  RecordingHistoryView.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import SwiftUI
import Rswift

struct RecordingHistoryView: View {

	var body: some View {
		NavigationView {
			List([Coordinate(latitude: 0.0, longitude: 0.0)]) { item in
				Text(item.debugDescription)
			}
			.navigationBarTitle(
				Text(R.string.localizable.recordingHistoryListTitle())
			)
		}
	}
}

struct RecordingHistoryView_Previews: PreviewProvider {
	static var previews: some View {
		RecordingHistoryView()
	}
}
