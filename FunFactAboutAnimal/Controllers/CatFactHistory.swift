//
//  CatFact.swift
//  FunFactAboutAnimal
//
//  Created by Yun Xu on 12/6/21.
//

import UIKit
import RealmSwift


class CatFactHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var catFactHistoryAry : [CatFactModel] = [CatFactModel]()

//    @IBOutlet weak var timestampLbl: UILabel!
//    @IBOutlet weak var histTxtView: UITextView!
    @IBOutlet weak var historyTblView: UITableView!
    
    //    let catFact = "Cats have individual preferences for scratching surfaces and angles. Some are horizontal scratchers while others exercise their claws vertically."

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTblView.dataSource = self
        historyTblView.delegate = self
        loadHistoryCatFacts()
    
      
    }
    func loadHistoryCatFacts() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = try! Realm()
        let facts = realm.objects(CatFactModel.self)
//        print("reading cat facts history from realm")
//        print(facts)
        self.catFactHistoryAry.removeAll()
        for fact in facts.reversed(){
            self.catFactHistoryAry.append(fact)

        }
        print(self.catFactHistoryAry.count)
//        self.historyTblView.reloadData()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catFactHistoryAry.count
    }




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! HistoryTableViewCell


        let curFact = catFactHistoryAry[indexPath.row]

        let timeStamp = curFact.timestamp
//        print("timestamp：\(timeStamp)")


        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)

        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.histTxtView.text = curFact.fact
        cell.timestampLbl.text = dformatter.string(from: date)
     

//        cell.textLabel?.text = String(format: "%@, %@", dformatter.string(from: date), curFact.fact)


        return cell
    }

    // MARK: - Table view data source


    
}
