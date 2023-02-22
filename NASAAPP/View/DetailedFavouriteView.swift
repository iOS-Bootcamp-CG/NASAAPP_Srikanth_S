//
//  DetailedFavouriteView.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 29/01/23.
//

import SwiftUI

//display detailed view from selected favouriteview by passing parameter
struct DetailedFavouriteView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title,order: .reverse)]) var nasa:FetchedResults<Nasa>
    var number:UUID
    var body: some View {
        ForEach(nasa) { nasa in
            HStack {
                VStack(alignment: .center){
                    //display details by matching parameter
                    if (nasa.imgid == number){
                            Image(uiImage: UIImage(data: nasa.image ?? Data()) ?? UIImage())
                            .resizable()
                            .scaledToFit()
                        Text(nasa.title ?? "Alt")
                            .font(.title)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        
                        ScrollView{
                            Text(nasa.imgdesc ?? "Alt")
                                .font(.subheadline)
                                .lineLimit(nil)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                
                        }
                    }
                }
                
            }
        }
    }
}

//struct DetailedFavouriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        let uuid = UUID(uuidString: "180B38D9-4A07-4D64-8E47-91251BE3D263")
//        DetailedFavouriteView(number: uuid!)
//    }
//}
