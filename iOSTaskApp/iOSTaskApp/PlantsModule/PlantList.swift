//
//  PlantList.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 09/11/2024.
//

import SwiftUI

struct PlantList: View {
    @EnvironmentObject var vm: PlantsModuleOpen.ViewModel
    
    var body: some View {
        GeometryReader { GeometryProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 15) {
                        ZStack(alignment: .trailing) {

                            Button {
                                withAnimation {
                                    proxy.scrollTo(
                                        houseLocation.all,
                                        anchor: .center)
                                    vm.selectedLocation = houseLocation.all
                                }

                            } label: {
                                ZStack {

                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                    .stroke(
                                        .lightCream,
                                        lineWidth: vm.selectedLocation
                                        == houseLocation.all ? 5 : 0
                                    )
                                    .frame(height: 50)

                                    Text(houseLocation.all.rawValue)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(
                                            .lightCream
                                        )
                                        .background(.clear)
                                        .padding(8)
                                 
                                }
                            }
                         

                        }.frame(height: 60)

                        ForEach(
                            vm.sortedByValue, id: \.key
                        ) { location, value in

                            ZStack(alignment: .trailing) {

                                Button {
                                    withAnimation {
                                        proxy.scrollTo(
                                            location,
                                            anchor: .center)
                                        vm.selectedLocation = location
                                    }

                                } label: {
                                    ZStack {

                                        RoundedRectangle(
                                            cornerRadius: 20
                                        )
                                        .stroke(
                                            .lightCream,
                                            lineWidth: vm.selectedLocation
                                                == location ? 5 : 0
                                        )
                                        .frame(height: 50)

                                        Text(location.rawValue)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(
                                                .lightCream
                                            )
                                            .background(.clear)
                                            .padding(8)

                                    }
                                  
                                }
                                if value.filter({ $0.watered == false && $0.waterDate.isToday() }).count
                                    > 0
                                {
                                    Circle()
                                        .fill(
                                            
                                            .lightOrange
                                        )
                                        .frame(
                                            width: 25,
                                            height: 25
                                        )
                                        .overlay {
                                            Text(
                                                "\(value.filter({$0.watered == false && $0.waterDate.isToday()}).count)  "
                                            )
                                            .foregroundStyle(
                                                .lightCream
                                            )
                                            .multilineTextAlignment(.center)
                                            .padding(1)

                                        }.offset(x: 10, y: -15)

                                }
                            }.frame(height: 60)

                        }

                    }.padding(.horizontal)
                }

            }.clipShape(RoundedRectangle(cornerRadius: 20))
               
        
                .frame(maxWidth: .infinity, alignment: .center)
         

        }
    }
}

#Preview {
    PlantList()
        .environmentObject(PlantsModuleOpen.ViewModel())
}
