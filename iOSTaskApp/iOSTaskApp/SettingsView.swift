//
//  SettingsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/11/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var name:String
    @State var editingName:Bool = false
    @State private var newUserName = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
  
        NavigationStack {
           
                
            Form{
                Section {
                    HStack{
                        Button {
                            editingName.toggle()
                            
                        } label: {
                            HStack {
                                Image(systemName: "person")
                                Text("Edit Name")
                            }
                      
                        }.alert("Enter new name", isPresented: $editingName) {
                            TextField("Enter your name", text: $newUserName)
                            Button("OK") {
                                name = newUserName
                            }
                        }

                    }
                } header: {
                    Text("User Settings")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        
                }

                Section {
                    HStack{
                        Image(systemName: "app.badge")

               //         Toggle("Enable Notifications", isOn: .)
                       
                    }
                } header: {
                    Text("Plants Module Settings")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        
                }

            }
            
        }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
     dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Utils.textColor(colorScheme))
                        
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        
                }
                        
            }
    }
}

#Preview {
    SettingsView(name: .constant("Lukas"))

}
