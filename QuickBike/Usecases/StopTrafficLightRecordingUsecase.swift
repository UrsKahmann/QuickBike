//
//  StopTrafficLightRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation

struct StopTrafficLightRecordingUsecase {

	func stop() {
		TrafficLightRecorder.shared.stopTrafficLightRecording()
	}
}
