//
//  RecordingRespository.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import CoreData
import Combine

protocol RecordingRepository {
	var context: NSManagedObjectContext? { get }
	var recordings: CurrentValueSubject<[Recording], Error> { get }
	func save() -> Error?
	func getAll()
	func delete(recording: Recording)
}

class RealRecordingRepository: RecordingRepository {

	static let shared = RealRecordingRepository()

	private let persistentStorage = PersistentStorage()
	internal let recordings = CurrentValueSubject<[Recording], Error>([])
	internal var context: NSManagedObjectContext?

	private init() {

		self.persistentStorage.load(completion: { [weak self] loadingError in
			if let error = loadingError {
				self?.recordings.send(completion: .failure(error))
			}
		})

		self.context = self.persistentStorage.context
	}

	func save() -> Error? {

		do {
			try self.persistentStorage.context.save()
		} catch {
			return error
		}

		return nil
	}

	func getAll() {

		do {
			let recordings = try self.persistentStorage.fetchRecordings()
				self.recordings.send(recordings)
		} catch {
			self.recordings.send(completion: .failure(error))
		}
	}

	func delete(recording: Recording) {
		self.persistentStorage.delete(recording: recording)
	}
}
