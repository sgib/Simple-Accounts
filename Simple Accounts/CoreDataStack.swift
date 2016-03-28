//
//  CoreDataStack.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    enum CoreDataError: ErrorType {
        case DatabaseError
    }
    
    enum StoreType {
        case Persistent
        case InMemory
    }
    
    private let managedObjectModelName: String
    private let storeURL: NSURL
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.managedObjectModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let store = try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.storeURL, options: nil)
        return coordinator
    }()
    
    private lazy var inMemoryStoreCoordinator: NSPersistentStoreCoordinator = {
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let store = try! coordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        return coordinator
    }()
    
    private var mainQueueContext: NSManagedObjectContext
    
    func reset() {
        mainQueueContext.reset()
    }
    
    func rollback() {
        mainQueueContext.rollback()
    }
    
    func saveChanges() -> CoreDataError? {
        var saveError: CoreDataError?
        mainQueueContext.performBlockAndWait({
            if self.mainQueueContext.hasChanges {
                do {
                    try self.mainQueueContext.save()
                } catch {
                    saveError = .DatabaseError
                }
            }
        })
        return saveError
    }
    
    func deleteEntity<T: NSManagedObject>(entity: T.Type, matchingPredicate predicate: NSPredicate?) -> CoreDataError? {
        let fetchRequest = NSFetchRequest(entityName: entity.entityName)
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        var deleteError: CoreDataError?
        mainQueueContext.performBlockAndWait({
            do {
                try self.mainQueueContext.executeRequest(deleteRequest)
            } catch {
                deleteError = .DatabaseError
            }
        })
        return deleteError
    }
    
    func createManagedEntity<T: NSManagedObject>(entity: T.Type) -> T {
        return NSEntityDescription.insertNewObjectForEntityForName(entity.entityName, inManagedObjectContext: mainQueueContext) as! T
    }
    
    func fetchEntity<T: NSManagedObject>(entity: T.Type, matchingPredicate predicate: NSPredicate?, sortedBy sortDescriptors: [NSSortDescriptor]?) -> FetchResult<T> {
        let fetchRequest = NSFetchRequest(entityName: entity.entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        
        var entities: [T]?
        var dataError: ErrorType?
        
        mainQueueContext.performBlockAndWait({
            do {
                entities = try self.mainQueueContext.executeFetchRequest(fetchRequest) as? [T]
            } catch {
                dataError = error
            }
        })
        
        if let fetchedEntities = entities {
            return .Success(fetchedEntities)
        } else if let error = dataError {
            return .Failure(error)
        } else {
            return .Failure(CoreDataError.DatabaseError)
        }
    }
    
    func getSingleEntity<T: NSManagedObject>(entity: T.Type, matchingPredicate predicate: NSPredicate) -> T? {
        let fetchResult = fetchEntity(entity, matchingPredicate: predicate, sortedBy: nil)
        if case let .Success(results) = fetchResult {
            return results.first
        } else {
            return nil
        }
    }

    
    init(modelName: String, storeType: StoreType) {
        managedObjectModelName = modelName
        let docsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        storeURL = docsDirectory.URLByAppendingPathComponent("\(managedObjectModelName).sqlite")
        
        mainQueueContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainQueueContext.persistentStoreCoordinator = (storeType == .Persistent) ? self.persistentStoreCoordinator : self.inMemoryStoreCoordinator
    }
}

extension NSManagedObject {
    class var entityName: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

