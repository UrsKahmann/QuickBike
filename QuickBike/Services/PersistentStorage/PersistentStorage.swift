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

	static let shared = PersistentStorage()

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
		let context = self.persistentContainer.viewContext
		if context.hasChanges {
			try context.save()
		}
	}
}
