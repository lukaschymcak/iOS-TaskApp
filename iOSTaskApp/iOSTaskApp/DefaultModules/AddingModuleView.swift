//
//  AddingModuleView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 16/10/2024.
//

import SwiftUI

struct AddingModuleView: View {
    var module:CreatingModuleData
    @State var tapped:Bool = false
    @State var selection:Color = .red
    var colors:[Color] = [.red,.green,.yellow,.orange]
    
   
    var body: some View {
            addingPackingModule(module: module,colors: colors,selection: $selection)
       
    }
}

struct addingPackingModule:View {
    var module:CreatingModuleData
    @Environment(\.dismiss) var dismiss
    @State var name:String = ""
    var colors:[Color]
    @Binding var selection:Color
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                VStack(alignment: .center){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .padding(.top,10)
                 
                    Text("\(module.name) \n Module")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,minHeight: 90,alignment: .center)
               
             
                }.padding(.vertical,2)
                
                VStack {
                   
                  
                    HStack{
                        Text("Name:")
                            .font(.title)
                            .fontWeight(.bold)
                        TextField("", text: $name)
                            .textFieldStyle(.roundedBorder)
                        addingModule(selection: $selection, name: $name, module: module)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom,20)
                    
                }.padding()
                Spacer()
            }.padding(.top,15)
            
        }
        .presentationDetents([.height(250)])
    }
}

struct addingModule: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Binding var selection:Color
    @Binding var name:String
    var module:CreatingModuleData
    var body: some View {
        Button {
            switch module.name {
            case "Packing":
                let packing = PackingModuleDataClass(name: name, colorName: selection.description)
                context.insert(packing)
                context.delete(DefaultModules.packing)
                dismiss()
            case "Plants":
                let plants = PlantsModuleDataClass(name: name, colorName: selection.description)
                context.insert(plants)
                context.delete(DefaultModules.plants)
                dismiss()
                
            default:
                return
            }
        } label: {
            Text("Add")
                .foregroundStyle(.white)
                .padding(8)
                .font(.headline)
                .background(selection)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    AddingModuleView(module: DefaultModules.packing)
        .modelContainer(for: [PackingModuleDataClass.self,CreatingModuleData.self,PlantsModuleDataClass.self])
}
