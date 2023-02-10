//
//  NetworkManager.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 18/01/23.
//

import Foundation
import SwiftUI

//makes objects observable and can automatically update when object changes
class NetworkManager:ObservableObject{

    //update this property automatically when changes take place
    @Published var apod:APODModel=APODModel()
    @Published var image:UIImage? = nil
    @Published var isLoading = false
    init(){
        fetchAPOD()
    }
    
    //fetch data from api
    func fetchAPOD(date : Date? = nil) {
        self.isLoading = true
        var url : URL?
        
        //if date is nil calls normal api else api with date
        if (date == nil){
            url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=WXpmOmR5htb3fwrEfQ0JQrzG3aHBLlRoLRc3t6hz")!

        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date!)
            url = URL(string: "https://api.nasa.gov/planetary/apod?date=\(dateString)&api_key=WXpmOmR5htb3fwrEfQ0JQrzG3aHBLlRoLRc3t6hz")!
        }
        
        let request = URLRequest(url: url!)
        
        //data task to retrieve contents of a URL.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    
                    // parse json data from data object
                    let decoder = JSONDecoder()
                    //parse json data and convert to instance of apod model
                    let apod = try decoder.decode(APODModel.self, from: data)
                    //make task asynchronous on main thread
                    DispatchQueue.main.async {
                        self.apod=apod
                        self.isLoading = false
                    }
                    self.fetchImage(imgurl:apod.url)
                }
                catch {
                    print(error)
                }
            }
        }
        //starts task
        task.resume()
    }
    
    func fetchImage(imgurl:String){
        guard let url = URL(string: imgurl) else {
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                        }
                    }
                }
                .resume()
        
    }
    
    
}


