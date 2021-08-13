//
//  StopTrafficLightRecordingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation

struct StopTrafficLightRecordingUseCase {

	func stop() {
		print("Stopped traffic light recording")
		TrafficLightRecorder.shared.stopTrafficLightRecording()
	}
}
