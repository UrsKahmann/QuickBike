//
//  LocationService.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import Foundation
import CoreLocation
import Combine

class LocationService: NSObject, ObservableObject {

	private let locationManager = CLLocationManager()

	@Published var location: CLLocation?
	@Published var error: Error?

	override init() {
		super.init()

		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.distanceFilter = kCLLocationAccuracyBest
		self.locationManager.delegate = self

		if self.locationManager.authorizationStatus == .notDetermined {
			self.locationManager.requestWhenInUseAuthorization()
		}
	}

	func startLocationDataCollection() {
		print("Started location tracking")
		self.locationManager.startUpdatingLocation()
	}

	func stopLocationDataCollection() {
		self.locationManager.stopUpdatingLocation()
	}
}

extension LocationService: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Location manager did fail: \(error.localizedDescription)")
		self.error = error
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let current = locations.last {
			self.location = current
		}
	}
}
