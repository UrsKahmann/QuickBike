//
//  MockLocationService.swift
//  QuickBike
//
//  Created by Urs Privat on 29.07.21.
//

import Foundation
import CoreLocation
import Combine

class MockLocationService: LocationProvider {

	private var tracking = false

	var location = PassthroughSubject<CLLocation, Error>()

	private let emitter: AnyPublisher<CLLocation, Never>

	private var cancellable = Set<AnyCancellable>()

	static private var mockLocationData: [CLLocation] = {
		let start = CLLocation(latitude: 52.5404466, longitude: 13.3550355)
		let stop = CLLocation(latitude: 52.5426994, longitude: 13.3534015)
		let directionVektor = stop - start
		var data = [start]
		for i in 1...100 {
			let new = start + (directionVektor * (Double(i) / 100.0))
			data.append(new)

			if i == 10 || i == 20 {
				for j in 1...10 {
					let standing = new + CLLocation(
						latitude: Double.random(in: 0.0000001...0.0000005),
						longitude: Double.random(in: 0.0000001...0.0000005)
					)

					data.append(standing)
				}
			}
		}

		return data
	}()

	enum MockLocationError: Error {
		case locationUnknown
	}

	static private func fakeError() -> Error {
		return MockLocationError.locationUnknown
	}

	init() {

		let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
		let coordinatePublisher = Publishers.Zip(MockLocationService.mockLocationData.publisher, timerPublisher)

		self.emitter = coordinatePublisher.map { (coordinate: CLLocation, _ : Date) in
			return coordinate
		}
		.eraseToAnyPublisher()

		self.emitter.filter({ [weak self] _ in
			return self?.tracking == true
		})
		.sink { (completion: Subscribers.Completion<Never>) in
			self.location.send(completion: .failure(MockLocationService.fakeError()))
		} receiveValue: { (location: CLLocation) in
			self.location.send(location)
		}
		.store(in: &cancellable)
	}

	func startLocationTracking() {
		self.tracking = true
	}

	func stopLocationTracking() {
		self.tracking = false
	}
}
