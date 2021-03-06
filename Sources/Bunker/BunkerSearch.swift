//
//  BunkerSearch.swift
//  
//
//  Created by Sam Spencer on 10/6/20.
//

import Foundation
import CoreData

public class BunkerSearch {
    
    public class func searchPredicate(for searchTerm: String) -> NSPredicate {
        let newPredicate = NSPredicate(format: "name contains[c] %@", searchTerm)
        return newPredicate
    }
    
}
