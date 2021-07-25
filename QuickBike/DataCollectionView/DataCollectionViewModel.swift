//
//  DataCollectionViewModel.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import Foundation
import Combine
import CoreLocation

class DataCollectionViewModel: ObservableObject {
	
	private let locationService = LocationService()
	
	@Published var location: CLLocation?
	@Published var error: Error?
	
	private var cancallable = Set<AnyCancellable>()
	
	init() {
		
		self.locationService
			.$location
			.sink(receiveValue: { (location) in
				self.location = location
			})
			.store(in: &cancallable)
		
		self.locationService
			.$error
			.sink(receiveValue: { (error) in
				self.error = error
			})
			.store(in: &cancallable)
	}
	
	func startLocationTracking() {
		self.locationService.startLocationDataCollection()
	}
	
	func stopLocationTracking() {
		self.locationService.stopLocationDataCollection()
	}
}
