//
//  TabNavigationView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView {
            NavigationView {
                SelectStoreView()
            }
            .tabItem {
                Image(systemName: "building.2.crop.circle")
                Text("Stores")
            }

            NavigationView {
                TipsView()
            }
            .tabItem {
                Image(systemName: "text.badge.star")
                Text("Tips")
            }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
