//
//  ContentView.swift
//  QuickBike
//
//  Created by Urs Privat on 24.07.21.
//

import SwiftUI
import Rswift

struct StartView: View {
	
	private var aboutInfoBox: some View {
		VStack(alignment: .leading) {
			Text(R.string.localizable.startInfoBoxHeader())
				.font(.headline)
				.padding(.leading)
			Divider()
				.padding(.horizontal)
			Text(verbatim: R.string.localizable.startInfoBoxText())
				.padding()
		}
		.padding()
	}
	
	private var startDataCollectionButton: some View {
		HStack {
			Spacer()
			NavigationLink(destination: DataCollectionView()) {
					Text(R.string.localizable.startDataCollectionButton())
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
	}
	
	var body: some View {
		
		NavigationView {
			VStack(alignment: .center) {
				TitleLabel()
				self.aboutInfoBox
				Spacer()
				self.startDataCollectionButton
			}
			.navigationBarHidden(true)
		}
	}
}

struct StartView_Previews: PreviewProvider {
	static var previews: some View {
		StartView()
	}
}
