//
//  SettingsView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2023-02-06.
//

import SwiftUI

struct SettingsView: View {
    @State private var path = NavigationPath()
    @State var selection: Int = 4
    @State var length: Int = 5
    @State var showTimer: Bool = true
    // @State var showResults = false
    // @State var teamNames = false
    
    var body: some View {
        
        NavigationView() {
            Form {
                Section(header: Text("Antal lag")) {
                    Picker(selection: $selection, label: Text("")) {
                        ForEach(2..<11) {
                            i in Text("\(i) Lag").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Picker(selection: $length, label: Text("Matchlängd")) {
                    ForEach(1..<60) {
                        i in Text("\(i) min.").tag(i)
                    }
                }
                
                Section {
                    Toggle(isOn: $showTimer,
                           label: {
                        Text("Visa timer")
                    })
                    /*
                    Toggle(isOn: $showResults,
                           label: {
                        Text("Ange matchresultat")
                    })
                    Toggle(isOn: $teamNames,
                           label: {
                        Text("Ange lagnamn ")
                    })
                    */
                }

                NavigationLink(destination: GameListView(showTimer: $showTimer, teamCount: self.selection, length: self.length * 60)){
                    Text("Gå vidare")
                }
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            }
            .navigationTitle("Inställningar")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
