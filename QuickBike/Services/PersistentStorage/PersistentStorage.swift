//
//  PersistentStorage.swift
//  QuickBike
//
//  Created by Urs Privat on 10.08.21.
//

import Foundation
import CoreData

class PersistentStorage {

	private enum Constants {
		static let persistanceContainerName = "QuickBike"
	}

	private lazy var persistentContainer: NSPersistentContainer = {
		NSPersistentContainer(name: PersistentStorage.Constants.persistanceContainerName)
	}()

	var context: NSManagedObjectContext {
		return self.persistentContainer.viewContext
	}

	func load(completion: @escaping (Error?) -> Void) {
		self.persistentContainer.loadPersistentStores { _, loadingError in
			completion(loadingError)
		}
	}

	func save() throws {
		if self.context.hasChanges {
			try context.save()
		}
	}

	func fetchRecordings() throws -> [Recording] {
		return try self.context.fetch(Recording.fetchRequest())
	}

	func delete(recording: Recording) {
		self.context.delete(recording)

		do {
			try self.context.save()
		} catch {
			// TODO: handle error better
			print("Error saving deleted state")
		}
	}
}
