////
//  PlantModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import Foundation
import SwiftData


@Model
class PlantModel:Hashable,Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    private(set) var name: String
    private var desc: String
    private(set) var location: houseLocation
    private(set) var frequency : Int
    private(set) var water : String
    private(set) var light:String
    private(set) var temp:String
    private(set) var image: String
    private(set) var watered:Bool
    private(set) var prepared:Bool = false
    private(set) var waterDate:Date = Date.now
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation = .bathroom, frequency: Int = 0, water: String = "", light: String = "",temp:String = "", image: String = "",watered:Bool = false,waterDate:Date = Date.now) {
        self.name = name
        self.desc = desc
        self.location = location
        self.frequency = frequency
        self.water = water
        self.light = light
        self.temp = temp
        self.image = image
        self.watered = watered
        self.waterDate = waterDate
    }
    
    func setName(a:String){
        self.name = a
    }
    func getDesc() -> String{
        
        return self.desc
    }
        
        func setLocation(a:houseLocation){
            self.location = a
        }
        func setFrequency(a:Int){
            self.frequency = a
        }
        func setWater(a:String){
            self.water = a
        }
        func setImage(a:String){
            self.image = a
        }
        func toggleWatered(){
            self.watered = true
        }
        func toggleNotWatered(){
            self.watered = false
        }
        func setWaterDate(a:Date){
            self.waterDate = a
        }
        
        func prepare(){
            self.prepared = true
        }
        func unPrepare(){
            self.prepared = false
        }
        func waterPlant() {
            if Calendar.current.isDate(waterDate, inSameDayAs: Date.now) {
                toggleWatered()
                if let dateIncrease = Calendar.current.date(
                    byAdding: .day, value: frequency,
                    to: waterDate)
                {
                    setWaterDate(a: dateIncrease)
                }
            }
            
            
            
            
            
            
        }
    }
  

struct MockPlants {
    
    static let plantA = PlantModel(name: "Kvet",location: .kitchen, frequency: 3,watered: true)
    static let plantB = PlantModel(name: "Kvet A",location: .bathroom)
    static let plantC = PlantModel(name: "Kvet B",location: .diningRoom)
    static let plantD = PlantModel(name: "Kvet C",location: .bathroom)
    static let plantE = PlantModel(name: "Kvet D",location: .livingRoom)
    
    static let mockedPlants:[PlantModel] = [plantA,plantB,plantC,plantD,plantE,plantA,plantA]
    
    
    
}
struct DefaultPlants {
    static let monstera = PlantModel(name: "Monstera",desc: "Monstera (Monstera deliciosa) is a popular tropical houseplant known for its large, glossy, heart-shaped leaves with unique holes and splits. It thrives in bright, indirect light and is low-maintenance, making it a favorite among plant enthusiasts. As a climbing plant, it can grow tall with proper support and adds a touch of greenery and elegance to indoor spaces.",water:"300ml", light:"Bright,Indirect",temp: "18-29°C" ,image: "monstera")
    
    static let orchidea = PlantModel(name: "Orchidea",desc: "Orchids (Phalaenopsis) are elegant tropical plants known for their stunning, long-lasting flowers. They thrive in bright, indirect light and require careful watering and humidity. With proper care, they bloom multiple times a year, making them a favorite for indoor spaces.",water:"100ml", light:"Bright,Indirect",temp: "18-29°C" ,image: "orchid")
    
    static let zzPlant = PlantModel(name: "ZZ Plant",desc: "The ZZ plant (Zamioculcas zamiifolia) is a hardy, low-maintenance indoor plant known for its glossy, dark green leaves and upright, wand-like stems. Native to East Africa, it's drought-tolerant and thrives in low to bright indirect light. This plant is popular for its ability to withstand neglect, making it ideal for beginners or low-light spaces. The ZZ plant also has air-purifying qualities and can grow up to 2-3 feet indoors with minimal watering.",water:"250ml", light:"Low to bright,indirect",temp: "18-29°C" ,image: "zz-plant")
    
    static let presetPlants:[PlantModel] = [monstera,orchidea,zzPlant]
}



