//
//  PlantCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantCell: View {
    var plantModule: PlantsModuleDataClass
    @State var plantCell: PlantModel
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    @State var color: Color = .red
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "9DA091"))

                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 1) {
                            Image("\(plantCell.image)")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(Color(hex: "EFD0CA"))
                                .padding()
                            VStack(spacing: 10) {
                                Text(plantCell.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "EFD0CA"))
                                    .lineLimit(2)
                                HStack {
                                    Image(systemName: "drop")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "EFD0CA"))
                                    Text(
                                        plantCell.waterDate,
                                        format: .dateTime.month().day()
                                    )
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "EFD0CA"))
                                }

                            }
                            Spacer()
                            VStack(spacing: 10) {
                                Button {
                                    
                                    plantModule.removePlants(a: plantCell)
                                    
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "EFD0CA"))
                                }.offset(y: -5)
                                if Calendar.current.isDateInToday(plantCell.waterDate){
                                    Button {
                                        plantCell.prepare()
                                    } label: {
                                        Image(
                                            systemName: plantCell.prepared
                                            ? "checkmark.circle" : "drop.circle"
                                        )
                                        .font(.system(size: 50))
                                        .foregroundStyle(Color(hex: "EFD0CA"))
                                    }.padding(.horizontal)
                                } else {
                                    Image(
                                        systemName: "clock"
                                    )
                                    .font(.system(size: 50))
                                    .foregroundStyle(Color(hex: "EFD0CA"))
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
        let today = Date.now
        let strippedDate = Calendar.current.dateComponents(
            [.year, .month, .day], from: today)
        return self < Calendar.current.date(from: strippedDate)!
    }

    func isToday() -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date.now)
    }
    func isTmrw() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}

#Preview {
    PlantCell(
        plantModule: MockPlantsModule.moduleA, plantCell: DefaultPlants.monstera
    )
}
