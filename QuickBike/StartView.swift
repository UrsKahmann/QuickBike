//
//  ContentView.swift
//  QuickBike
//
//  Created by Urs Privat on 24.07.21.
//

import SwiftUI
import Rswift

struct StartView: View {
	
	private var header: some View {
		HStack {
			Text("Quick")
				.font(.largeTitle)
				.padding(.top, 4)
			Image(systemName: "bicycle")
				.resizable()
				.frame(width: 50, height: 30, alignment: .center)
		}
		.padding(.top)
	}
	
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
			Button(action: {
				print("")
			}) {
				Text(R.string.localizable.startDataCollectionButton())
					.font(.headline)
					.foregroundColor(.green)
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.green, lineWidth: 2)
					)
			}
			.padding()
			Spacer()
		}
	}
	
	var body: some View {
		
		NavigationView {
			VStack(alignment: .center) {
				self.header
				self.aboutInfoBox
				Spacer()
				self.startDataCollectionButton
			}
			.navigationBarHidden(true)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		StartView()
	}
}
