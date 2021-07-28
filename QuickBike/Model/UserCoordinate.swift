//
//  UserCoordinate.swift
//  QuickBike
//
//  Created by Urs Privat on 26.07.21.
//

import Foundation

struct UserCoordinate: Identifiable {
	let id = UUID()
	let latitude: Double
	let longitude: Double

	var debugDescription: String {
		return "ID: \(self.id) | lat: \(self.latitude) | long: \(self.longitude)"
	}
}

extension UserCoordinate {

	static func + (lhs: UserCoordinate, rhs: UserCoordinate) -> UserCoordinate {
		return UserCoordinate(
			latitude: lhs.latitude + rhs.latitude,
			longitude: lhs.longitude + rhs.longitude
		)
	}

	static func - (lhs: UserCoordinate, rhs: UserCoordinate) -> UserCoordinate {
		return UserCoordinate(
			latitude: lhs.latitude - rhs.latitude,
			longitude: lhs.longitude - rhs.longitude
		)
	}

	static func * (lhs: UserCoordinate, rhs: Double) -> UserCoordinate {
		return UserCoordinate(
			latitude: lhs.latitude * rhs,
			longitude: lhs.longitude * rhs
		)
	}
}
