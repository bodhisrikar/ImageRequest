//
//  ViewController.swift
//  ImageRequest
//
//  Created by Srikar Thottempudi on 3/13/19.
//  Copyright © 2019 Srikar Thottempudi. All rights reserved.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {

    @IBOutlet weak var loadedImage: UIImageView!
    
    let imageLocation = KittenImageLocation.http.rawValue
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        guard let imageURL = URL(string: imageLocation) else {
            print("The provided URL is not valid")
            return
        }
        
        /*let task = URLSession.shared.dataTask(with: imageURL, completionHandler: {(data, response, error) in
            guard let data = data else {
                print("No data, or there was an error")
                return
            }
            
            let downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.loadedImage.image = downloadedImage
            }
        })
        
        task.resume()*/
        
        let task = URLSession.shared.downloadTask(with: imageURL, completionHandler: {(location, response, error) in
            guard let location = location else {
                print("Not a proper location")
                return
            }
            
            print(location)
            
            let data = try! Data(contentsOf: location)
            let downloadedImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.loadedImage.image = downloadedImage
            }
        })
        task.resume()
    }
    
}

