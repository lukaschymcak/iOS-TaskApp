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
    private(set) var isCustom:Bool = false
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation = .bathroom, frequency: Int = 0, water: String = "", light: String = "",temp:String = "", image: String = "",watered:Bool = false,waterDate:Date = Date.now,isCustom:Bool = false) {
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
        self.isCustom = isCustom
        
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
    func setLight(a:String){
        self.light = a
    }
    func setTemp(a:String){
        self.temp = a
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
                if let dateIncrease = Calendar.current.date(
                    byAdding: .day, value: frequency,
                    to: waterDate)
                {
                    setWaterDate(a: dateIncrease)
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
    static let monstera = PlantModel(name: "Monstera",desc: "Monstera (Monstera deliciosa) is a popular tropical houseplant known for its large, glossy, heart-shaped leaves with unique holes and splits. It thrives in bright, indirect light and is low-maintenance, making it a favorite among plant enthusiasts. As a climbing plant, it can grow tall with proper support and adds a touch of greenery and elegance to indoor spaces.",water:"300", light:"Bright,Indirect",temp: "18-29°C" ,image: "monstera")
    
    static let orchidea = PlantModel(name: "Orchidea",desc: "Orchids (Phalaenopsis) are elegant tropical plants known for their stunning, long-lasting flowers. They thrive in bright, indirect light and require careful watering and humidity. With proper care, they bloom multiple times a year, making them a favorite for indoor spaces.",water:"100", light:"Bright,Indirect",temp: "18-29°C" ,image: "orchid")
    
    static let zzPlant = PlantModel(name: "ZZ Plant",desc: "The ZZ plant (Zamioculcas zamiifolia) is a hardy, low-maintenance indoor plant known for its glossy, dark green leaves and upright, wand-like stems. Native to East Africa, it's drought-tolerant and thrives in low to bright indirect light. This plant is popular for its ability to withstand neglect, making it ideal for beginners or low-light spaces. The ZZ plant also has air-purifying qualities and can grow up to 2-3 feet indoors with minimal watering.",water:"250", light:"Low to bright,indirect",temp: "18-29°C" ,image: "zz-plant")
    static let snakePlant = PlantModel(
        name: "Snake Plant",
        desc: "The Snake Plant (Dracaena trifasciata) is a resilient and low-maintenance plant with tall, sword-like leaves featuring green and yellow variegation. Known for its air-purifying qualities, it thrives in a variety of lighting conditions and requires minimal watering. Ideal for bedrooms or low-light areas, it can grow up to 2-3 feet indoors.",
        water: "300",
        light: "Low to bright, indirect",
        temp: "15-27°C",
        image: "snake-plant"
    )
    static let spiderPlant = PlantModel(
        name: "Spider Plant",
        desc: "The Spider Plant (Chlorophytum comosum) is a hardy and adaptable houseplant with long, arching, variegated leaves. It’s known for producing small baby plants on stems and is perfect for hanging planters. It’s an excellent choice for beginners and grows up to 2 feet tall and wide.",
        water: "300",
        light: "Bright, indirect",
        temp: "15-24°C",
        image: "spider-plant"
    )
    static let aloeVera = PlantModel(
        name: "Aloe Vera",
        desc: "Aloe Vera (Aloe barbadensis) is a versatile succulent with thick, fleshy leaves filled with gel known for its medicinal and skincare benefits. It thrives in bright light and requires minimal care, growing up to 2 feet indoors.",
        water: "200",
        light: "Bright, indirect to direct",
        temp: "13-27°C",
        image: "aloe-vera"
    )
    static let africanViolet = PlantModel(
        name: "African Violet",
        desc: "The African Violet (Saintpaulia) is a compact houseplant with fuzzy leaves and vibrant flowers in purple, pink, or white. Known for its continuous blooms under proper care, it’s a popular choice for tabletops and windowsills.",
        water: "200",
        light: "Bright, indirect",
        temp: "18-24°C",
        image: "african-violet"
    )
    
    static let plantImages = ["monstera","orchid","zz-plant","snake-plant","spider-plant","aloe-vera","african-violet"]
    
    static let presetPlants:[PlantModel] = [monstera,orchidea,zzPlant,snakePlant,spiderPlant,aloeVera,africanViolet]
}



