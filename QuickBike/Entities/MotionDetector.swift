//
//  MotionDetector.swift
//  QuickBike
//
//  Created by Urs Privat on 28.07.21.
//

import Foundation

struct MotionDetector {

	enum Constants {
		static let standingThreshold = 0.0000003
		static let minSensitivity = 0.0000001
		static let maxSensitivity = 0.000001
	}

	private var accumulatedDistance = 0.0
	private var lastCoordinate: Coordinate?

	mutating func checkIfStanding(with coordinate: Coordinate, threshold: Double = Constants.standingThreshold) -> Bool {
		guard let lastCoordinate = self.lastCoordinate else {
			self.lastCoordinate = coordinate
			return false
		}

		self.accumulatedDistance = lastCoordinate.distance(to: coordinate)
		self.lastCoordinate = coordinate

		if self.accumulatedDistance < threshold {
			return true
		}

		return false
	}
}
