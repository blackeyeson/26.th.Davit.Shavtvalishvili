//
//  TakenNote+CoreDataProperties.swift
//  26.th.Davit.Shavtvalishvili
//
//  Created by a on 26.08.22.
//
//

import Foundation
import CoreData


extension TakenNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TakenNote> {
        return NSFetchRequest<TakenNote>(entityName: "TakenNote")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension TakenNote : Identifiable {

}
