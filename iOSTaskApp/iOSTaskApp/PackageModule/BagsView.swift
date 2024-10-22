//
//  BagsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 21/10/2024.
//

import SwiftUI
import SwiftData

struct BagsView: View {
    var trip:Trip
    var color:Color
  
    @State var addingBag:Bool = false
    var body: some View {
        GeometryReader { GeometryProxy in
            VStack {
                VStack(alignment: .center){
                    CustomNavBarModule(module: "Packing", name: "Trip")
                        .padding(.top,30)
                        .frame(width: GeometryProxy.size.width - 30,height: 25)
                }.frame(maxWidth: .infinity)
                VStack(alignment: .center){
                    Text(trip.name)
                        .font(.title)
                        .fontWeight(.bold)
                    color.frame(width: GeometryProxy.size.width - 30, height: 5)
                        .clipShape(.rect(cornerRadius: 20))
                    VStack{
                        Text(trip.dateFrom , format: .dateTime.day().month().year())
                        Text(trip.dateTo , format: .dateTime.day().month().year())
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(width: GeometryProxy.size.width - 40)
            HStack {
                Text("MY BAGS:")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                Spacer()
                Button {
                    addingBag.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .frame(width: GeometryProxy.size.width - 40)
            .frame(maxWidth: .infinity)
                    HStack{
                        ForEach(trip.bags){ bag in
                            Text(bag.name)
                          
                        }
                    }
                
               
                
                   
        }
            
        }
        .sheet(isPresented: $addingBag) {
            AddingBagView(bags: trip.bags,trip:trip)
        }
     
    }
}


struct AddingBagView:View {
    @Environment(\.modelContext) var context
    @State var bag = Bags(name: "", items: [])
    @State var bagName:String = ""
    @State var bags:[Bags]
    var trip:Trip
    var body: some View {
        VStack{
            HStack{
                Text("Name")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                TextField("Enter Name", text: $bagName)
                    .padding()
                    .background(Color.gray.cornerRadius(10))
                    .foregroundColor(.black)
            }
            Button(action: {
                let bag = Bags(name: bagName, items: [],trip: trip)
                bags.append(bag)
            }, label: {
                Text("add")
            })
            .padding()
            Spacer()
        }
    }
}

struct ItemCell:View {
    @Environment(\.modelContext) var context
    let item:Item
    var body: some View {
        ZStack {
            HStack{
                Image(systemName:item.marker )
                Text(item.name)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Button {
                    context.delete(item)
                } label: {
                    Image(systemName: "x.circle")
                }
                
                
                
                
            }.padding(6)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        
    }
}

struct CollapsableBag:View {
    var name:String
    let collums: [GridItem] = [
        GridItem(.fixed(300),spacing: 0,alignment: .leading),
    ]
    @State var isCollapsed:Bool = true
    @Binding var items:[String]
    @Binding var isChecked:Bool
    @State var selectedItem:String = ""
    var body: some View {
        VStack {
            Button {
                isCollapsed.toggle()
            } label: {
                HStack{
                    Text(name)
                    Spacer()
                    Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                }.frame(maxWidth: .infinity)
                    .frame(width: 300)
            }
            LazyVGrid(columns: collums) {
              
                }
                      }
                      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: isCollapsed ? 0 : .none)
                      .clipped()
                      .animation(.easeInOut, value: isCollapsed)
                      .transition(.slide)
        }

    }


#Preview {
    BagsView(trip: MockData.tripData, color: .orange)
        .modelContainer(for:[Item.self,Bags.self,PackingModuleDataClass.self])
}
