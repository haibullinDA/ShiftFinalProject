//
//  NewMO+CoreDataProperties.swift
//  News App
//
//  Created by Даниил Хайбуллин on 23.06.2022.
//
//

import Foundation
import CoreData


extension NewMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewMO> {
        return NSFetchRequest<NewMO>(entityName: "New")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var author: String?
    @NSManaged public var imageName: String?
    @NSManaged public var descriptionResult: String?
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?
    @NSManaged public var link: String?

}

extension NewMO : Identifiable {

}
