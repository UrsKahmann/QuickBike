//
//  LocationService.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import Foundation
import CoreLocation
import Combine

protocol LocationProvider {
	var location: PassthroughSubject<CLLocation, Error> { get }
	func startLocationTracking()
	func stopLocationTracking()
}

class LocationService: NSObject, ObservableObject, LocationProvider {

	private let locationManager = CLLocationManager()

	let location = PassthroughSubject<CLLocation, Error>()

	override init() {
		super.init()

		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.distanceFilter = kCLLocationAccuracyBest
		self.locationManager.delegate = self

		if self.locationManager.authorizationStatus == .notDetermined {
			self.locationManager.requestWhenInUseAuthorization()
		}
	}

	func startLocationTracking() {
		self.locationManager.startUpdatingLocation()
	}

	func stopLocationTracking() {
		self.locationManager.stopUpdatingLocation()
	}
}

extension LocationService: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Location manager did fail: \(error.localizedDescription)")
		self.location.send(completion: .failure(error))
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let current = locations.last {
			self.location.send(current)
		}
	}
}
