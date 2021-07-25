//
//  DataCollectionView.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import SwiftUI
import Rswift

struct DataCollectionView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var viewModel = DataCollectionViewModel()
	
	private var locationString: String {
		guard let location = self.viewModel.location else {
			return "Location not availabel!"
		}
		
		return "Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)"
	}

	var body: some View {
		
		VStack(alignment: .center) {
			TitleLabel()
			Text("Current Location:")
			Text("\(self.locationString)")
			Spacer()
			HStack {
				Spacer()
				Button(action: {
					self.viewModel.stopLocationTracking()
					self.presentationMode.wrappedValue.dismiss()
				}) {
					Text("Finish data collection")
						.font(.headline)
						.foregroundColor(.blue)
						.padding()
						.overlay(
							RoundedRectangle(cornerRadius: 10)
								.stroke(Color.blue, lineWidth: 2)
						)
				}
				.padding()
				Spacer()
			}
		}.navigationBarHidden(true)
		.onAppear() {
			self.viewModel.startLocationTracking()
		}
	}
}

struct DataCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		DataCollectionView()
	}
}
