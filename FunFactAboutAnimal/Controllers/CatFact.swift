//
//  CatFact.swift
//  FunFactAboutAnimal
//
//  Created by Yun Xu on 12/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class CatFact: UIViewController {
        
    
    
    @IBOutlet weak var factText: UITextView!
        
    
    let loadingtext = "loading..."

    override func viewDidLoad() {
        super.viewDidLoad()
//        factText.text = catFact
        self.factText.text = loadingtext
        getCatFact()
        //loadHistoryCatFacts()

    }
    
  

    func addCatFactToDB(_ factText: String) {
        print(factText)
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let fact = CatFactModel()
        fact.fact = factText
        fact.timestamp = timeStamp
        do {
            let realm = try! Realm()
            try realm.write{
                realm.add(fact)
            }
        } catch {
            print("Error in initializing realm")
        }
    }
    
    
    func getCatFact(){
        // Network call from there
       Alamofire.request(catURL).responseJSON { response in
           
           if response.error != nil {
               print(response.error?.localizedDescription)
           } else {
                           
               let json = JSON(response.value)

               let retval = json["fact"].stringValue
               
               if retval != "" {
                   self.factText.text = retval
                   self.addCatFactToDB(retval)
               } else {
                   self.factText.text = "oops! Something's wrong..."
               }
           }
          
           
           
       }
    }

    
    
}
