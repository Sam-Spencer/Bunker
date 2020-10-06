//
//  BunkerNotifier.swift
//  
//
//  Created by Sam Spencer on 10/6/20.
//

import Foundation

/// Sent each time the Core Data's Managed Object Context has been saved.
class BunkerNotifier {
    
    fileprivate var observer: Any? = nil
    
    func addObserver(_ block: @escaping (Notification) -> Void) {
        if self.observer == nil {
            self.observer = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave,
                                                                   object: Bunker.stack.context,
                                                                   queue: nil,
                                                                   using: block)
        }
    }
    
    func removeObserver() {
        if let observer = self.observer {
            NotificationCenter.default.removeObserver(observer)
            self.observer = nil
        }
    }
    
}
