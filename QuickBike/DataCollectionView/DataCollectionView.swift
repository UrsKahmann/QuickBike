//
//  DataCollectionView.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import SwiftUI
import Rswift
import MapKit

struct DataCollectionView: View {

	@Environment(\.presentationMode) var presentationMode

	@ObservedObject var viewModel = DataCollectionViewModel()

	var body: some View {

		VStack(alignment: .center) {
			TitleLabel()
			Text("Current Location:")
			Text("Latitude: \(self.viewModel.currentLocation?.latitude ?? 0)")
			Text("Longitude: \(self.viewModel.currentLocation?.longitude ?? 0)")
			Map(coordinateRegion: self.$viewModel.region, annotationItems: self.viewModel.annontationItems()) {
				MapAnnotation(
					coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude),
					anchorPoint: CGPoint.zero,
					content: {
						Circle()
							.stroke(lineWidth: 5)
							.foregroundColor(.green)
				})
			}
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
		.onAppear {
			self.viewModel.startLocationTracking()
		}
	}
}

struct DataCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		DataCollectionView()
	}
}
