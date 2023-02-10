//
//  APODView.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 19/01/23.
//

import Foundation
import SwiftUI

struct APODView: View {
    
    //obserbed object to take changes from network manager
    @ObservedObject var networkmanager = NetworkManager()
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjContext
    var body: some View {
        if networkmanager.isLoading {
            
            ProgressView()
        }
        else{
        VStack {
            HStack{
                //date picker to fetch apod data based on date
                
                DatePicker("", selection: $selectedDate,  in: ...Date(),displayedComponents: .date)
                    .onChange(of: selectedDate) { value in
                        self.networkmanager.fetchAPOD(date: value)
                        self.presentation.wrappedValue.dismiss()
                    }
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    
                
                
                //add to our favorite list
                Button(action:{
                    self.showAlert = true
                    Datacontroller().addData(title: networkmanager.apod.title, img:networkmanager.apod.url,image:networkmanager.image!.pngData()!, imgdesc: networkmanager.apod.description,context: managedObjContext)
                }){
                    Image(systemName: "heart")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("APOD"), message: Text("Image Added to Favourite"), dismissButton: .default(Text("OK")))
                }
            }.padding(.horizontal)
            
            
            //fetching contents of url to data and to uiimage to display
            
            
                if networkmanager.image != nil {
                    Image(uiImage: networkmanager.image!)
                        .resizable()
                        .scaledToFit()
                    
                }
                
                Text(networkmanager.apod.title)
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                
                ScrollView{
                    Text(networkmanager.apod.description)
                        .font(.subheadline)
                        .lineLimit(nil)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                }
            }
        }
            
        }
    }
struct APODView_Previews: PreviewProvider {
    static var previews: some View {
        APODView()
    }
}
    //VStack(){
    //    HStack(){
    //        DatePicker("Select", selection: $selectedDate, displayedComponents: .date)
    //        Button(action: {
    //            self.networkmanager.fetchAPOD(date: self.selectedDate)
    //        }) {
    //            Image(systemName: "magnifyingglass")
    //        }
    //        Button("Favourite"){
    //            Datacontroller().adddata(title: networkmanager.apod.title, img:networkmanager.apod.url,context: managedObjContext)
    //        }
    //    }.padding(.horizontal)
    //
    //    AsyncImage(url: URL(string: networkmanager.apod.url))
    //        .frame(width: 300,height: 200,alignment: .topLeading )
    //        .aspectRatio(contentMode: .fill)
    //        .clipped()
    //    ScrollView{
    //        VStack(alignment: .leading, spacing: 20){
    //            Text(networkmanager.apod.title)
    //            Text(networkmanager.apod.description)
    //        }.padding()
    //    }
    //}
    //.ignoresSafeArea()
