//
//  ContentView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2022-11-16.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 2
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Välj antal Lag")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Picker(selection: $selection, label: Text("")) {
                    ForEach(2..<11) {
                        i in Text("\(i) Lag").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                //Text("\(selection) Lag")
                NavigationLink(destination: PushedView(teamCount: self.$selection)){
                    Text("SPELA")
                }
                .buttonStyle(.borderedProminent)
                .fontWeight(.semibold)
            }
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
