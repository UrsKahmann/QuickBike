//
//  StartTrafficLightRecordingUseCase.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation

struct StartTrafficLightRecordingUseCase {

	func start(coordinate: Coordinate) {
		print("Started traffic light recording")
		TrafficLightRecorder.shared.startTrafficLightRecording(coordinate: coordinate)
	}
}
