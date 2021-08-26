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

extension Coordinate: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.latitude)
		hasher.combine(self.longitude)
		hasher.combine(self.id)
	}

	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		return
			lhs.latitude == rhs.latitude &&
			lhs.longitude == rhs.longitude &&
			lhs.id == rhs.id
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
}
