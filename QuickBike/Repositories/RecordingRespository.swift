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
	var recordings: CurrentValueSubject<[Recording], Error> { get }
	func add(recording: Recording) -> Error?
	func getAll()
}

class RealRecordingRepository: RecordingRepository {

	let persistentStorage = PersistentStorage()

	let recordings = CurrentValueSubject<[Recording], Error>([])

	init() {
		self.persistentStorage.load(completion: { [weak self] loadingError in
			if let error = loadingError {
				self?.recordings.send(completion: .failure(error))
			}
		})
	}

	func add(recording: Recording) -> Error? {

		_ = recording.toCoreDataEntity(in: self.persistentStorage.context)

		do {
			try self.persistentStorage.context.save()
		} catch {
			return error
		}

		return nil
	}

	func getAll() {

		let fetchRequest: NSFetchRequest<CDRecording> = CDRecording.fetchRequest()

		do {
			let cdRecordings = try self.persistentStorage.context.fetch(fetchRequest)
			let recordings = cdRecordings.compactMap({ cdRecording in
				Recording.fromCoreDataEntity(cdRecording)
			})

			self.recordings.send(recordings)
		} catch {
			self.recordings.send(completion: .failure(error))
		}
	}

}
