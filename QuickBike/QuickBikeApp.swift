//
//  QuickBikeApp.swift
//  QuickBike
//
//  Created by Urs Privat on 24.07.21.
//

import SwiftUI

@main
struct QuickBikeApp: App {
	var body: some Scene {
		WindowGroup {
			TabView {
				StartView()
					.tabItem {
						Image(systemName: "record.circle")
						Text("Data Recording")
					}
				RecordingHistoryView()
					.tabItem {
						Image(systemName: "list.bullet")
						Text("Data")
					}
			}
		}
	}
}
