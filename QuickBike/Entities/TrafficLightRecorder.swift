//
//  TrafficLightRecorder.swift
//  QuickBike
//
//  Created by Urs Privat on 13.08.21.
//

import Foundation
import CoreData

struct TrafficLightRecorder {

	static var shared = TrafficLightRecorder()

	private enum Constants {
		static let dataModelVersion = 1
	}

	private var managedObjectsContext: NSManagedObjectContext?

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
			let coordinate = self.trafficLightCoordinate,
			let context = self.managedObjectsContext {
				let newTrafficLightRecording = TrafficLightRecording(context: context)

				newTrafficLightRecording.version = Int16(TrafficLightRecorder.Constants.dataModelVersion)
				newTrafficLightRecording.startTimeStamp = start
				newTrafficLightRecording.stopTimeStamp = Date()
				newTrafficLightRecording.setCoordinate(coordinate)

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

	mutating func startRecording(in context: NSManagedObjectContext) {
		self.managedObjectsContext = context
		self.trafficLightRecordings = []
		self.date = Date()
		self.isRecording = true
	}

	mutating func finishRecording() -> Recording? {
		self.isRecording = false

		if
			let date = self.date,
			let context = self.managedObjectsContext,
			self.trafficLightRecordings.isEmpty == false {
				let recording = Recording(context: context)
				recording.date = date
				recording.data = NSOrderedSet(array: self.trafficLightRecordings)
				return recording
		}

		return nil

	}
}
