//
//  CLLocationCoordinate2D+Extension.swift
//  QuickBike
//
//  Created by Urs Privat on 26.07.21.
//

import Foundation
import CoreLocation
import CoreData

typealias Coordinate = CLLocationCoordinate2D

extension Coordinate: Identifiable {
	public var id: ObjectIdentifier {
		return ObjectIdentifier(NSString(string: "\(self.latitude)\(self.longitude)"))
	}
}

extension Coordinate {

	var debugDescription: String {
		return "ID: \(self.id) | lat: \(self.latitude) | long: \(self.longitude)"
	}

	static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
		return Coordinate(
			latitude: lhs.latitude + rhs.latitude,
			longitude: lhs.longitude + rhs.longitude
		)
	}

	static func - (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
		return Coordinate(
			latitude: lhs.latitude - rhs.latitude,
			longitude: lhs.longitude - rhs.longitude
		)
	}

	static func * (lhs: Coordinate, rhs: Double) -> Coordinate {
		return Coordinate(
			latitude: lhs.latitude * rhs,
			longitude: lhs.longitude * rhs
		)
	}

	func distance(to otherCoordinate: Coordinate) -> Double {
		let distance = sqrt(
			pow(self.latitude - otherCoordinate.latitude, 2) +
				pow(self.longitude - otherCoordinate.longitude, 2)
		)

		return distance
	}

	func toCoreDataEntity(in context: NSManagedObjectContext) -> CDCoordinate {
		let entity = CDCoordinate(context: context)
		entity.latitude = self.latitude
		entity.longitude = self.longitude

		return entity
	}

	static func fromCoreData(_ entity: CDCoordinate) -> Coordinate {
		return Coordinate(
			latitude: entity.latitude,
			longitude: entity.longitude
		)
	}
}
