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
    
    private lazy var mainQueueContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        return moc
    }()
    
    
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
    
    func getManagedEntity<T: NSManagedObject>(entity: T.Type, matchingPredicate predicate: NSPredicate, usingConversionFunction function: (T) -> ()) -> T {
        if let managedEntity = getSingleEntity(entity, matchingPredicate: predicate) {
            return managedEntity
        } else {
            let newEntity = NSEntityDescription.insertNewObjectForEntityForName(entity.entityName, inManagedObjectContext: mainQueueContext) as! T
            function(newEntity)
            return newEntity
        }
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
    
    private func getSingleEntity<T: NSManagedObject>(entity: T.Type, matchingPredicate predicate: NSPredicate) -> T? {
        let fetchResult = fetchEntity(entity, matchingPredicate: predicate, sortedBy: nil)
        if case let .Success(results) = fetchResult {
            return results.first
        } else {
            return nil
        }
    }

    
    init(modelName: String) {
        managedObjectModelName = modelName
        let docsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        storeURL = docsDirectory.URLByAppendingPathComponent("\(managedObjectModelName).sqlite")
    }
}

extension NSManagedObject {
    class var entityName: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

