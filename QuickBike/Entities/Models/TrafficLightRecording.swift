//
//  TrafficLightRecording.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import CoreData

struct TrafficLightRecording: Identifiable {
	let id = UUID()
	let version: Int
	let coordinate: Coordinate
	let startTimeStamp: Date
	let stopTimeStamp: Date

	static func fromCoreDataEntity(_ entity: CDTrafficLightRecording) -> TrafficLightRecording? {
		guard
			let coordinate = entity.coordinate,
			let start = entity.startTimeStamp,
			let stop = entity.stopTimeStamp else {
				return nil
		}

		return TrafficLightRecording(
			version: Int(entity.version),
			coordinate: Coordinate.fromCoreData(coordinate),
			startTimeStamp: start,
			stopTimeStamp: stop)
	}

	func toCoreDataEntity(in context: NSManagedObjectContext) -> CDTrafficLightRecording {
		let entity = CDTrafficLightRecording(context: context)

		entity.version = Int16(self.version)
		entity.coordinate = self.coordinate.toCoreDataEntity(in: context)
		entity.startTimeStamp = self.startTimeStamp
		entity.stopTimeStamp = self.stopTimeStamp

		return entity
	}
}
