//
//  DataBaseService.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import CoreData

protocol IDetailDataBaseService: AnyObject {
    func createNew(new: FavoriteModel)
    func objectExist(withLink link: String) -> Bool
    func deleteObject(withLink link: String) -> String?
}
protocol IFavoriteDataBaseService: AnyObject {
    func fetchNews() -> [NewMO]?
}

final class DataBaseService {
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
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
}

extension DataBaseService: IDetailDataBaseService {
    func createNew(new: FavoriteModel) {
        let newMO = NewMO(context: self.viewContext)
        newMO.id = new.id
        newMO.title = new.title
        newMO.author = new.author
        newMO.date = new.date
        newMO.imageName = new.imageName
        newMO.descriptionResult = new.description
        newMO.content = new.content
        newMO.link = new.link
        print(NSPersistentContainer.defaultDirectoryURL())
        self.saveContext()
    }
    
    func objectExist(withLink link: String) -> Bool {
        let request = NewMO.fetchRequest()
        request.predicate = NSPredicate(format: "link == %@", link)
        request.fetchLimit = 1
        do {
            let count = try self.viewContext.count(for: request)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func deleteObject(withLink link: String) -> String? {
        let request = NewMO.fetchRequest()
        request.predicate = NSPredicate(format: "link == %@", link)
        do {
            guard let newMO = try viewContext.fetch(request).first else { return nil }
            let name = newMO.imageName
            viewContext.delete(newMO)
            saveContext()
            return name
        } catch let error {
            print(error)
            return nil
        }
    }
}

extension DataBaseService: IFavoriteDataBaseService {
    func fetchNews() -> [NewMO]? {
        let request = NewMO.fetchRequest()
        return try? self.viewContext.fetch(request)
    }
}
