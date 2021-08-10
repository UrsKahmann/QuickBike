//
//  Recording.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import CoreData

struct Recording: Identifiable {

	let id = UUID()
	let date: Date
	let data: [TrafficLightRecording]

	static func fromCoreDataEntity(_ entity: CDRecording) -> Recording? {
		guard
			let date = entity.date,
			let trafficLightRecordings = entity.data?.array as? [CDTrafficLightRecording] else {
				return nil
		}

		return Recording(
			date: date,
			data: trafficLightRecordings.compactMap({ entity in
				TrafficLightRecording.fromCoreDataEntity(entity)
			})
		)
	}

	func toCoreDataEntity(in context: NSManagedObjectContext) -> CDRecording {
		let entity = CDRecording(context: context)

		entity.date = self.date
		entity.data = NSOrderedSet(array: self.data.map({ trafficLightRecording -> CDTrafficLightRecording in
			trafficLightRecording.toCoreDataEntity(in: context)
		}))

		return entity
	}
}
