//
//  ContentView.swift
//  QuickBike
//
//  Created by Urs Privat on 24.07.21.
//

import SwiftUI

struct StartView: View {
	var body: some View {
		
		NavigationView {
		
			VStack(alignment: .leading) {
				HStack {
					Spacer()
					Text("Quick Bike")
						.font(.largeTitle)
						.padding()
					Image(systemName: "bicycle")
						.resizable()
						.frame(width: 45, height: 30, alignment: .center)
					Spacer()
				}
				
				//Divider()
				Text("What is Quick Bike?")
					.font(.headline)
					.padding(.leading)
				Divider()
					.padding(.horizontal)
				Text("This is a prototype for collecting data on traffic light phases. The goal is to ...")
					.padding()
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						print("")
					}) {
						Text("Start data collection")
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
			Spacer()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		StartView()
	}
}
