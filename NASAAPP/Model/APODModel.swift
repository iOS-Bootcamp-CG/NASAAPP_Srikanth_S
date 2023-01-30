//
//  APODModel.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 19/01/23.
//

import Foundation

struct APODModel : Codable {
    var title:String
    var description:String
    var url:String
    var date:String
    
    //match struct variables to source data case
    enum CodingKeys:String, CodingKey{
        case title="title"
        case description="explanation"
        case url="url"
        case date="date"
        
    }
    
    //decodes
    init(from decoder:Decoder) throws{
        let valueContainer=try decoder.container(keyedBy: CodingKeys.self)
        self.title=try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description=try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url=try valueContainer.decode(String.self, forKey: CodingKeys.url)
        self.date=try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    init(){
        self.description = ""
        self.title = ""
        self.date = ""
        self.url = ""
    }
    
}
