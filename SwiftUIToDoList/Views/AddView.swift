//
//  addView.swift
//  SwiftUIToDoList
//
//  Created by Milena Lima de Alcântara on 06/10/22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showAddTodoView: Bool
    
    @State private var name: String = ""
    @State private var selectedCategory = 0
    
    var categoryTypes = ["Family","Personal","Work"]
    
    var body: some View {
        Form {
            Section {
                TextField("Activity Name", text: $name)
            } header: {
                Text("What do you want to do?")
            }
            
            Section {
                Picker("Select a category",selection: $selectedCategory) {
                    ForEach(0 ..< 3) {
                        Text(self.categoryTypes[$0])
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Select a category")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showAddTodoView = false
                    let newTodoCD = TodoCD(context: viewContext)
                    newTodoCD.name = name
                    newTodoCD.category = categoryTypes[selectedCategory]
                    do {
                        try viewContext.save()
                    } catch {
                        let error = error as NSError
                        fatalError("unressolved error:\(error)")
                    }
                } label: {
                    Text("Done")
                }
            }
        }
    }
}
 /**
  Form {
      Text("New Activity")
          .font(.largeTitle)
      
      Section() {
          TextField("Activity Name", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .border(Color.black)
              .padding(8)
              .border(.gray)
              .cornerRadius(9)
          
      } header: {
          Text("What do you want to do?")
      }
      
      Text("Select category")
      Picker("",selection: $selectedCategory) {
          ForEach(0 ..< categoryTypes.count) {
              Text(self.categoryTypes[$0])
          }
      }
      .pickerStyle(SegmentedPickerStyle())
  }
  .padding()
  .navigationBarTitleDisplayMode(.automatic)
  
      
  Button("Done") {
  self.showAddTodoView = false
  let newTodoCD = TodoCD(context: viewContext)
      newTodoCD.name = name
      newTodoCD.category = categoryTypes[selectedCategory]
      do {
          try viewContext.save()
      }
      catch {
          let error = error as NSError
          fatalError("unressolved error:\(error)")
      }
  }
  */
