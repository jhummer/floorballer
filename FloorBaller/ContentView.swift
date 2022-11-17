//
//  ContentView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2022-11-16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State var selection = 4
    @State var length = 5
    
    var body: some View {
        
        NavigationView() {
            Form {
                Section(header: Text("Välj antal lag")) {
                    Picker(selection: $selection, label: Text("")) {
                        ForEach(2..<11) {
                            i in Text("\(i) Lag").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Picker(selection: $length, label: Text("Längd på matcher (min.)")) {
                    ForEach(1..<60) {
                        i in Text("\(i) min.").tag(i)
                    }
                }
                
                Section(footer: Text("Lagnamn anges i nästa steg, annars 1, 2, 3 ...")) {
                    Toggle(isOn: .constant(false),
                           label: {
                        Text("Egna lagnamn")
                    })
                }
                

                NavigationLink(destination: PushedView(teamCount: self.$selection)){
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

struct PushedView: View {
    
    @Binding var teamCount: Int
    
    var body: some View {
        Text("Spelschema:")
            .font(.largeTitle)
            .fontWeight(.heavy)
        
        let games = generateGameSchedule()
        
        ForEach(games, id: \.self) { game in
            Text("\(game.home) - \(game.away)")
                .font(.largeTitle)
                .fontWeight(.heavy)
        }
    }

    
    struct Game: Hashable {
        let home: Int
        let away: Int
    }
    
    func generateGameSchedule() -> [Game] {
        var teams = [Int]()
        for i in 1 ... teamCount {
            teams.append(i)
        }

        var games = [(Int, Int)]()

        for team in teams {
            for opponent in teams[team...] {
                games.append((team, opponent))
            }
        }

        var games_to_play = games.count
        var previous_teams = [Int]()
        var game_schedule = [Game]()

        while games_to_play != 0 {
            var game_found = false
            for teams in games {
                // TODO: fix the check for previous teams
                if (!previous_teams.contains(teams.0) && !previous_teams.contains(teams.1)) {
                    game_schedule.append(
                        Game(home: teams.0, away: teams.1)
                    )
                    previous_teams = [teams.0, teams.1]
                    games = games.filter{$0 != teams}
                    game_found = true
                    games_to_play -= 1
                }
            }
            if !game_found {
                var games_iter = games.makeIterator()
                let game: (Int, Int) = games_iter.next()!
                game_schedule.append(
                    Game(home: game.0, away: game.1)
                )
                previous_teams = [game.0, game.1]
                games = games.filter{$0 != game}
                games_to_play -= 1
            }
        }
        return game_schedule
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
