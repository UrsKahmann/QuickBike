//
//  StartTrafficLightRecordingUsecase.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation

struct StartTrafficLightRecordingUsecase {

	func start(coordinate: Coordinate) {
		TrafficLightRecorder.shared.startTrafficLightRecording(coordinate: coordinate)
	}
}
