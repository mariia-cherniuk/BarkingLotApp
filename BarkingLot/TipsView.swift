//
//  TipsView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

struct Tips: Decodable, Identifiable {
    var id: String { title }
    var title: String
    var body: String
}

struct TipsView: View {
    let tips = Bundle.main.decode([Tips].self, from: "tips.json")

    var body: some View {
        List(tips) { tip in
            VStack(alignment: .leading) {
                Text(tip.title)
                    .font(.headline)

                Text(tip.body)
            }
            .padding()
        }
        .navigationTitle("Grooming Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
