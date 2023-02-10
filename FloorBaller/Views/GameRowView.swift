//
//  GameRowView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2023-02-06.
//

import SwiftUI

struct GameRowView: View {
    var game: Game
    @State var hasPlayed: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Text("\(game.home) - \(game.away)")
                    .font(.title)
                    .foregroundColor(hasPlayed ? .gray : .black)
            }
        }
    }
}

struct GameRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameRowView(game: Game(home: 1, away: 2))
    }
}
