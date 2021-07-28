//
//  TestLocationRepository.swift
//  QuickBike
//
//  Created by Urs Privat on 27.07.21.
//

import Foundation
import Combine

class TestLocationRepository: LocationRepository {
	
	private var emitting = false
	
	private lazy var locationData: [UserCoordinate] = {
		let start = UserCoordinate(latitude: 52.5404466, longitude: 13.3550355)
		let stop = UserCoordinate(latitude: 52.5426994, longitude: 13.3534015)
		let directionVektor = stop - start
		var data = [start]
		for i in 1...100 {
			let new = start + (directionVektor * (Double(i) / 100.0))
			data.append(new)
			
			if (i == 50) {
				for j in 1...20 {
					let standing = new + UserCoordinate(latitude: Double.random(in: 0.000001...0.000005), longitude: Double.random(in: 0.000001...0.000005))
					data.append(standing)
				}
			}
		}
		
		return data
	}()
	
	func startLocationTracking() {
		self.emitting = true
	}
	
	func stopLocationTracking() {
		self.emitting = false
	}
	
	func getLocations() -> AnyPublisher<UserCoordinate, Never> {
		
		let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
		let coordinatePublisher = Publishers.Zip(self.locationData.publisher, timerPublisher)
		
		return coordinatePublisher.map { (coordinate: UserCoordinate, date: Date) in
			return coordinate
		}.eraseToAnyPublisher()
	}
}
