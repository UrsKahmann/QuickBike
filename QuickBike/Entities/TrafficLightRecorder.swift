//
//  TrafficLightRecorder.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation

struct TrafficLightRecorder {

	static var shared = TrafficLightRecorder()

	private enum Constants {
		static let dataModelVersion = 1
	}

	private var trafficLightRecordings = [TrafficLightRecording]()
	private var date: Date?
	private var isRecording = false

	private var trafficLightStartTime: Date?
	private var trafficLightCoordinate: Coordinate?

	private init() {}

	mutating func startTrafficLightRecording(coordinate: Coordinate) {
		guard self.isRecording == true else {
			return
		}

		self.trafficLightCoordinate = coordinate
		self.trafficLightStartTime = Date()
	}

	mutating func stopTrafficLightRecording() {
		guard self.isRecording == true else {
			return
		}

		if
			let start = self.trafficLightStartTime,
			let coordinate = self.trafficLightCoordinate {
				let newTrafficLightRecording = TrafficLightRecording(
					version: TrafficLightRecorder.Constants.dataModelVersion,
					coordinate: coordinate,
					startTimeStamp: start,
					stopTimeStamp: Date()
				)

			self.trafficLightRecordings.append(newTrafficLightRecording)
		}
	}

	mutating func cancelTrafficLightRecording() {
		guard self.isRecording == true else {
			return
		}

		self.trafficLightStartTime = nil
		self.trafficLightCoordinate = nil
	}

	mutating func startRecording() {
		self.trafficLightRecordings = []
		self.date = Date()
		self.isRecording = true
	}

	mutating func finishRecording() -> Recording? {
		self.isRecording = false

		if let date = self.date {
			return Recording(
				date: date,
				data: self.trafficLightRecordings
			)
		}

		return nil

	}
}
