//
//  TrafficLightRecording+CoreDataClass.swift
//  
//
//  Created by Urs Privat on 26.08.21.
//
//

import Foundation
import CoreData

@objc(TrafficLightRecording)
public class TrafficLightRecording: NSManagedObject {

	var coordinate: Coordinate {
		return Coordinate(latitude: self.latitude, longitude: self.longitude)
	}

	func setCoordinate(_ coordinate: Coordinate) {
		self.latitude = coordinate.latitude
		self.longitude = coordinate.longitude
	}
}
