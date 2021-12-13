//
//  DogImage.swift
//  FunFactAboutAnimal
//
//  Created by Yun Xu on 12/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI

class DogImage: UITableViewController {

    
    @IBOutlet var dogImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set default image
        self.dogImg = UIImageView(image: UIImage(named: "loadingpage-1"))
        self.dogImg.frame = CGRect(x: 0, y: 20, width: 414, height: 458)
        self.view.addSubview(self.dogImg)
        
        // get a dog image asynchronously
        getDogImage()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    func getDogImage() {
        // Network call from there
       Alamofire.request(dogURL).responseJSON { response in
           
           if response.error != nil {
               print(response.error?.localizedDescription)
           } else {
             
               let json = JSON(response.value)

               let status = json["status"].stringValue
               let message = json["message"].stringValue
               
               print(status)
               if status != "success" {
                   print(message)
               } else {
                   print(message)
//                   self.dogImg.dowloadFromServer(link: message, contentMode: .scaleAspectFill)
                   
                   self.dogImg.dowloadFromServer(link: message,
                   contentMode: .scaleAspectFill)
//                   self.view.addSubview(self.dogImg)
                   
               }
               
             
           }
          
           
           
       }
    }

}

extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        print("1")
        guard let url = URL(string: link) else { return }
        print("2")
        dowloadFromServer(url: url, contentMode: mode)
    }
}
