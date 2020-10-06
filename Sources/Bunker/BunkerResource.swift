//
//  BunkerResource.swift
//  
//
//  Created by Sam Spencer on 10/6/20.
//

import Foundation
import CoreData

@objc(Item)
extension NSManagedObject {
    
    
    // MARK: - Helpers
    
    @nonobjc public class func fetchRequest(_ name: String) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: name)
    }
    
    class func count() -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = self.fetchRequest()
        
        do {
            let count = try Bunker.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Creation and Deletion
    
    class func create() -> Self {
        return Self(context: Bunker.stack.context)
    }
    
    public func delete() {
        Bunker.stack.context.delete(self)
    }
    
}

