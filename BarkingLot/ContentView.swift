//
//  ContentView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = DataModel(canPurchase: true)

    var body: some View {
        TabNavigationView()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
