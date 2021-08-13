//
//  StartRecordingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 08.08.21.
//

import Foundation

struct StartRecordingUseCase {

	func start() {
		print("Starting recording")
		TrafficLightRecorder.shared.startRecording()
	}
}
