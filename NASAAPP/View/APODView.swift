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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title,order: .reverse)]) var nasa:FetchedResults<Nasa>
    @State private var checkapod:Bool = false
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
                    showAlert = true
                    self.checkapod = checkApod(date: networkmanager.apod.date)
                    if self.checkapod == false{
                        Datacontroller().addData(title: networkmanager.apod.title, img:networkmanager.apod.url,image:networkmanager.image!.pngData()!, imgdesc: networkmanager.apod.description,imgdate:networkmanager.apod.date,context: managedObjContext)
                    }
                }){
                    Image(systemName:checkApod(date: networkmanager.apod.date) ? "heart.fill" : "heart")

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .alert(isPresented: $showAlert) {
                    if self.checkapod == true{
                        return Alert(title: Text("APOD"), message: Text("Image is already Added to Favourite"), dismissButton: .default(Text("OK")))
                    }
                    else{
                        return Alert(title: Text("APOD"), message: Text("Image Added to Favourite"), dismissButton: .default(Text("OK")))
                    }
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
    
    func checkApod(date:String)->Bool{
        
        for i in nasa{
            if let imgdate = i.imgdate{
                if imgdate == date{
                    return true
                }
            }
        }
        return false
    }
    
    }
struct APODView_Previews: PreviewProvider {
    static var previews: some View {
        APODView()
    }
}

