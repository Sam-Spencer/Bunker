//
//  Bunker.swift
//
//
//  Created by Sam Spencer on 10/6/20.
//

import Foundation
import CoreData
import UserDefault


protocol BunkerRadio {
    func needsPersistentContainerName() -> String
}


/// A shared Core Data stack and manager.
class Bunker {
    
    
    // MARK: - Properties
    
    /// Singleton for the Core Data stack and its management.
    public static let stack = Bunker()
    
    /// The `Bunker` delegate
    public var delegate: BunkerRadio?
    
    /// The name of your app's persistent container.
    /// This must be set prior to accessing the container.
    var containerName: String = ""
    
    /// Determines whether or not the initial routine has been completed.
    @UserDefault("Bunker.stack.hasInitializedDatabase") private var hasInitializedDatabase: Bool? = false
    
    
    // MARK: - Core Data Stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        if containerName == "" {
            containerName = delegate?.needsPersistentContainerName() ?? "Model"
            print("Warning: No persistent container name has been specified. Bunker will attempt to use the name \"Model\", but if your actual model name does not match expect to see a crash momentarily.")
        }
        
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved Core Data error \(nserror), \(nserror.userInfo)")
            }
        })
        return container
    }()
    
    public var context: NSManagedObjectContext {
        get {
            return self.persistentContainer.viewContext
        }
    }
    
    
    // MARK: - Core Data Saving Support
    
    public func save() {
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Saved changes to the Core Data stack.")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved Core Data error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Database Setup
    
    public func initializeDatabase(_ setup: @escaping () -> Void) {
        guard hasInitializedDatabase == false else { return }
        setup()
        hasInitializedDatabase = true
    }
    
    public func resetDatabaseInitialization() {
        hasInitializedDatabase = false
    }
    
    
    // MARK: - Managed Object Helpers
    
    class func executeBlockAndCommit(_ block: @escaping () -> Void) {
        block()
        Bunker.stack.save()
    }
    
}
