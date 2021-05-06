//
//  StarsManager.swift
//  App2
//
//  Created by Stefano D’Amato on 04/05/21.
//

import UIKit
import CoreData

class StarsManager{
    static let name = "Stars"
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    static func newStarsManager () -> Stars {
        let context = getContext()
        let starsmanager = NSEntityDescription.insertNewObject(forEntityName: self.name, into: context) as! Stars
        
        starsmanager.user = PersistenceManager.fetchData()[0]
        starsmanager.level1 = 0
        starsmanager.level2 = 0
        starsmanager.level3 = 0
        starsmanager.level4 = 0
        starsmanager.level5 = 0
        starsmanager.level6 = 0
        starsmanager.level7 = 0
        starsmanager.level8 = 0
        starsmanager.level9 = 0
        starsmanager.level10 = 0
                
        saveContext()
        return starsmanager
    }
    static func fetchData() -> [Stars] {
        var stars = [Stars]()
        let context = getContext()
        let fetchRequest = NSFetchRequest<Stars>(entityName: name)
        do {
            try stars = context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Errore in fetch \(error.code)")
        }
        saveContext()
        return stars
    }
    static func saveContext() {
        let context = getContext()
        do {
            try context.save()
        } catch {}
    }
}
