//
//  PlantCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantCell: View {
    var plantModule: PlantsModuleDataClass
    @Binding var selectedPlant: PlantModel?
    @State var plantCell: PlantModel
    @State var showWaterAlert: Bool = false
    @State var showDeleteAlert: Bool = false
    @State var alertMessage: String = ""
    @State var color: Color = .red
    @Binding  var toast: Toast?
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "697442"))

                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 1) {
                            Image("\(plantCell.image)")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding()
                            VStack(spacing: 10) {
                                Text(plantCell.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .lineLimit(2)
                                HStack {
                                    Image(systemName: "drop")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "FEFAE0"))
                                    Text(
                                        plantCell.waterDate,
                                        format: .dateTime.month().day()
                                    )
                                    .font(.title2)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                }

                            }
                            Spacer()
                            VStack(spacing: 10) {
                                Button {
                                    showDeleteAlert.toggle()
                                    
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "FEFAE0"))
                                }.offset(y: -5)
                                .alert(isPresented: $showDeleteAlert) {
                                        Alert(title: Text("Remove Plant ?"), primaryButton: .destructive(Text("Confirm"), action: {
                                            toast = Toast(style: .success, message: "Plant Removed",doOutsideFunctonImage: "")
                                            plantModule.removePlants(a: plantCell)
                                       
                                        }) , secondaryButton: .cancel())
                                    }

                                if Calendar.current.isDateInToday(plantCell.waterDate) || plantCell.waterDate.isBeforeToday() {

                                    Button {
                                        if plantCell.waterDate.isBeforeToday() {
                                            showWaterAlert.toggle()
                                            
                                        }else {
                                            plantCell.prepare()
                                            toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                                            selectedPlant = plantCell
                                        }
                                    } label: {
                                        Image(
                                            systemName: plantCell.prepared
                                            ? "checkmark.circle" : "drop.circle"
                                        )
                                        .font(.system(size: 50))
                                        .foregroundStyle(Color(hex: "FEFAE0"))
                                    }.padding(.horizontal)
                                        .alert(isPresented: $showWaterAlert) {
                                            Alert(title: Text("Water Plant ?"), primaryButton: .destructive(Text("You forgot to water this plant , once watered next watering date will be calculated from today"), action: {
                                                plantCell.prepare()
                                                toast = Toast(style: .success, message: "Plant Watered",doOutsideFunctonImage: "arrow.uturn.backward")
                                                selectedPlant = plantCell
                                            }) , secondaryButton: .cancel())
                                        }.disabled(plantCell.prepared)
                                } else {
                                    Image(
                                        systemName: "clock"
                                    )
                                    .font(.system(size: 50))
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .padding(.horizontal)
                                }
                            }

                        }.frame(maxWidth: .infinity, alignment: .leading)

                    }

                }

            }.frame(width: GeometryProxy.size.width - 10)
                .frame(height: 120)
                .frame(maxWidth: .infinity, alignment: .center)
        }

    }
   
}
extension Date {
    func isBeforeToday() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        if let daysDifference = calendar.dateComponents([.day], from: self, to: now).day {
            return daysDifference > 0
        }
        
        return false
    }

    func isToday() -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date.now)
    }
    func isTmrw() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}


