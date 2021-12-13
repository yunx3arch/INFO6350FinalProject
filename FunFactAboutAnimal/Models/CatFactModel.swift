//
//  CatFactModel.swift
//  FunFactAboutAnimal
//
//  Created by Xiao on 2021/12/8.
//

import Foundation
import RealmSwift

class CatFactModel: Object{
    @objc dynamic var length : Int = Int.min
    @objc dynamic var fact : String = ""
    @objc dynamic var timestamp : Int = Int.min
    
    override static func primaryKey() -> String? {
        return "timestamp"
    }

    
}

