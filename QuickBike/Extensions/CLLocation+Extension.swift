//
//  CLLocation+Extension.swift
//  QuickBike
//
//  Created by Urs Privat on 29.07.21.
//

import Foundation
import CoreLocation

extension CLLocation {

	static func + (lhs: CLLocation, rhs: CLLocation) -> CLLocation {
		return CLLocation(
			latitude: lhs.coordinate.latitude + rhs.coordinate.latitude,
			longitude: lhs.coordinate.longitude + rhs.coordinate.longitude
		)
	}

	static func - (lhs: CLLocation, rhs: CLLocation) -> CLLocation {
		return CLLocation(
			latitude: lhs.coordinate.latitude - rhs.coordinate.latitude,
			longitude: lhs.coordinate.longitude - rhs.coordinate.longitude
		)
	}

	static func * (lhs: CLLocation, rhs: Double) -> CLLocation {
		return CLLocation(
			latitude: lhs.coordinate.latitude * rhs,
			longitude: lhs.coordinate.longitude * rhs
		)
	}
}
