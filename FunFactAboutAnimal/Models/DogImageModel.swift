//
//  DogImageModel.swift
//  FunFactAboutAnimal
//
//  Created by Xiao on 2021/12/8.
//

import Foundation
import RealmSwift

class DogImageModel : Object {
    @objc dynamic var imageURL : String = ""
    @objc dynamic var timestampe : Int = Int.min

    override static func primaryKey() -> String? {
        return "timestampe"
    }
}
