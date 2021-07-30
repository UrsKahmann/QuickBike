//
//  MotionDetector.swift
//  QuickBike
//
//  Created by Urs Privat on 28.07.21.
//

import Foundation

struct MotionDetector {

	private enum Constants {
		static let standingThreshold = 0.000001
	}

	private var accumulatedDistance = 0.0
	private var lastCoordinate: UserCoordinate?

	mutating func checkIfStanding(with coordinate: UserCoordinate) -> Bool {
		guard let lastCoordinate = self.lastCoordinate else {
			self.lastCoordinate = coordinate
			return false
		}

		self.accumulatedDistance = lastCoordinate.distance(to: coordinate)
		self.lastCoordinate = coordinate

		print("Accumulated distance: \(self.accumulatedDistance)")

		if self.accumulatedDistance < Constants.standingThreshold {
			return true
		}

		return false
	}
}
