//
//  DataController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/26.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

class DataController: NSObject {
    var persistentContainer: NSPersistentContainer!
    
    init(completionClosure: @escaping() -> ()) {
        persistentContainer = NSPersistentContainer(name: "KokoikeModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            
            completionClosure()
            
        }
    }
    
    func createLocation() -> Location {
        let context = persistentContainer.viewContext
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as! Location
        return location
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func countLocations() -> Int {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            let count = try context.count(for: request)
            return count
        } catch {
            fatalError("Failed to fetch locations: \(error)")
        }
        return -1
    }

    func fetchLocationById(id: Int32) -> Location? {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.predicate = NSPredicate(format: "id=" + String(id))
        do {
            let locations = try context.fetch(request) as! [Location]
            return locations[0]
        } catch {
            fatalError("Failed to fetch locations: \(error)")
        }
        return nil
    }
    
    func fetchLocations() -> [Location] {
        func completion(json: JSON) -> Void {
            print(json)
        }
        API.sharedInstance.getLocations(completion: completion)
        let context = persistentContainer.viewContext
        let locationsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")

        do {
            let fetchedLocations = try context.fetch(locationsFetch) as! [Location]
            return fetchedLocations
        } catch {
            fatalError("Failed to fetch locations: \(error)")
        }
        return []
    }
    
    func deleteLocation(_ deleteLocation: Location) {
        let context = persistentContainer.viewContext
        let deleteRequest: NSFetchRequest<Location> = Location.fetchRequest()
        deleteRequest.predicate = NSPredicate.init(format: "idl==\(deleteLocation.id)")
        
        do {
            let objects = try context.fetch(deleteRequest)
            for object in objects {
                context.delete(object)
            }
            saveContext()
            print("deleted location")
        } catch {
            fatalError("Failed to fetch locations: \(error)")
        }
    }
    
    func registerNewLocation(name: String, address: String?, tel: String?, comment: String?, url: String?, imageURL: String?, lat: Float,lon: Float) {
        let newLocation = createLocation()
        newLocation.id = Int32(countLocations())
        newLocation.name = name
        if let address = address {
            newLocation.address = address
        }
        if let tel = tel {
            newLocation.tel = tel
        }
        
        if let comment = comment {
            newLocation.comment = comment
        }
        
        if let url = url {
            newLocation.url = url
        }
        
        if let imageURL = imageURL {
            newLocation.image_url = imageURL
        }

        newLocation.lat = lat
        newLocation.lon = lon
        newLocation.created_at = NSDate() as Date
        
        func comp(json: JSON) -> Void {
            newLocation.id = Int32(json["id"].intValue)
            print("new location id is")
            print(json["id"].intValue)
            saveContext()
        }
        API.sharedInstance.createLocation(location: newLocation, completion: comp)
    }
}
