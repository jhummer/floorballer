//
//  GameListView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2023-02-06.
//

import SwiftUI

struct GameListView: View {
    @Binding var showTimer: Bool
    @State var teamCount = 4
    @State var length = 5 * 60
    
    var body: some View {
        let gameSchedule = generateGameSchedule(teams: teamCount)
        NavigationView() {
            VStack {
                Spacer()
                ForEach(gameSchedule, id: \.self) { game in
                    GameRowView(game: game, hasPlayed: false)
                }
                Spacer()
                Divider()
                if showTimer {
                    TimerView(countdownTime: length)
                }
            }
            .navigationTitle("Matcher")
        }
        .navigationBarHidden(true)
    }
}

func generateGameSchedule(teams teamCount: Int) -> [Game] {
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

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(showTimer: .constant(true))
    }
}
