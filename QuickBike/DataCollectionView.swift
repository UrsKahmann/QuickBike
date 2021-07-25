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

	var body: some View {
		
		VStack(alignment: .center) {
			TitleLabel()
			Spacer()
			HStack {
				Spacer()
				Button(action: {
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
	}
}

struct DataCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		DataCollectionView()
	}
}
