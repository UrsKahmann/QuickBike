//
//  RecordingPoint+CoreDataClass.swift
//  QuickBike
//
//  Created by Urs Privat on 13.02.22.
//
//

import Foundation
import CoreData

@objc(RecordingPoint)
public class RecordingPoint: NSManagedObject {

	var coordinate: Coordinate {
		return Coordinate(latitude: self.latitude, longitude: self.longitude)
	}

	func set(coordinate: Coordinate) {
		self.latitude = coordinate.latitude
		self.longitude = coordinate.longitude
	}
}
