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

	@ObservedObject var viewModel = ViewModelFactory.shared.dataCollectionViewModel

	private var statusLabel: some View {
		VStack {
			switch self.viewModel.motionState {
			case .moving:
				Text("Moving")
					.font(.headline)
					.foregroundColor(.green)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.green, lineWidth: 2)
					)
			case .standing:
				Text("Standing")
					.font(.headline)
					.foregroundColor(.red)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.red, lineWidth: 2)
					)
			case .unknown:
				Text("Unknown")
					.font(.headline)
					.foregroundColor(.gray)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.gray, lineWidth: 2)
					)
			}
		}
	}

	private var statusSection: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Latitude: \(String(format: "%.05f", self.viewModel.currentLocation?.latitude ?? 0))")
				Text("Longitude: \(String(format: "%.05f", self.viewModel.currentLocation?.longitude ?? 0))")
			}

			Spacer()

			self.statusLabel
		}
		.padding(.horizontal)
	}

	var body: some View {

		VStack(alignment: .center) {
			TitleLabel()
			self.statusSection
			Text("Sesitivity: \(String(format: "%0.8f", self.viewModel.motionDetectionSensitivity))")
				.padding(.vertical)
			Slider(
				value: self.$viewModel.motionDetectionSensitivity,
				in: MotionDetector.Constants.minSensitivity ... MotionDetector.Constants.maxSensitivity,
				step: MotionDetector.Constants.minSensitivity,
				onEditingChanged: { _ in
					self.viewModel.sensitivityChanged()
				},
				label: {
					EmptyView()
				}
			)
			.padding(.horizontal)

			Map(coordinateRegion: self.$viewModel.region, annotationItems: self.viewModel.annontationItems()) {
				MapAnnotation(
					coordinate: Coordinate(latitude: $0.latitude, longitude: $0.longitude),
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
					_ = self.viewModel.save(recording: nil)
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
		.alert(isPresented: self.$viewModel.didStop) {
			Alert(
				title: Text("You stopped!"),
				message: Text("Did you stop at a red light?"),
				dismissButton: .default(Text("YES!"))
			)
		}
	}
}

struct DataCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		DataCollectionView()
	}
}
