//
//  FavView.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 20/01/23.
//

import SwiftUI

struct FavouriteView: View {

    //to use moc of core data stack
    @Environment(\.managedObjectContext) var managedObjContext
    // to fetch the sorted nasa entity
   @FetchRequest(sortDescriptors: [SortDescriptor(\.title,order: .reverse)]) var nasa:FetchedResults<Nasa>
    var body: some View {
        
        NavigationView{
                List{
                    ForEach(nasa) { nasa in
                        HStack {
                            VStack(alignment: .center){
                                //to navigate to detailedfavouriteview by passing imgid as parameter
                                NavigationLink(destination: DetailedFavouriteView(number: nasa.imgid!)) {
                                    Image(uiImage: UIImage(data: nasa.image ?? Data()) ?? UIImage())
                                        .frame(width: 350,height: 200,alignment: .center )
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                }
                                    Text(nasa.title ?? "Alt")
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            
                        }
                    }
                    .onDelete(perform: deleteData)
                    
                }.listStyle(.plain)
                    .navigationBarTitle("Favourites", displayMode: .inline)
            
        }
        .navigationViewStyle(.stack)
}

    //delete entities corresponds to indexes in the indexset
    private func deleteData(at offsets: IndexSet) {
                offsets.map { nasa[$0] }.forEach(managedObjContext.delete)
                Datacontroller().Save(context: managedObjContext)
        }
}
struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
