//
//  UserProvider.swift
//  Rawg
//
//  Created by Bryan on 01/11/22.
//

import CoreData
import SwiftUI

class UserProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User")

        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }

    // MARK: - Get all favorite games
    func getFavorites(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
            fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [FavoriteModel] = []
                for result in results {
                    let favorite = FavoriteModel(
                        id: result.value(forKeyPath: "id") as? Int32,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                        isFavorite: result.value(forKeyPath: "isFavorite") as? Bool
                    )

                    favorites.append(favorite)
                }
                completion(.success(favorites))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }

    // MARK: - Get favorite game by ID
    func getFavoriteById(_ id: String, completion: @escaping (Result<FavoriteModel, Error>) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let favorite = FavoriteModel(
                        id: result.value(forKeyPath: "id") as? Int32,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                        isFavorite: result.value(forKeyPath: "isFavorite") as? Bool
                    )
                    completion(.success(favorite))
                } else {
                    completion(.success(FavoriteModel(isFavorite: false)))
                }
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
    }

    // MARK: - Create favorite game
    func createFavorite(
        id: String,
        name: String,
        backgroundImage: String,
        isFavorite: Bool,
        completion: @escaping () -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                favorite.setValue(Int32(id), forKeyPath: "id")
                favorite.setValue(name, forKeyPath: "name")
                favorite.setValue(backgroundImage, forKeyPath: "backgroundImage")
                favorite.setValue(isFavorite, forKeyPath: "isFavorite")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }

    // MARK: - Update favorite game
    func updateFavorite(
        id: String,
        name: String,
        backgroundImage: String,
        isFavorite: Bool,
        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            if (try? taskContext.fetch(fetchRequest).first) != nil {
                self.deleteFavorite(id: id) {
                    completion()
                }
            } else {
                self.createFavorite(id: id, name: name, backgroundImage: backgroundImage, isFavorite: isFavorite) {
                    completion()
                }
            }
        }
    }

    // MARK: - Delete favorite game
    func deleteFavorite(
        id: String,
        completion: @escaping() -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
}
