//
//  DataModel.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

class DataModel: ObservableObject {
    @Published var canPurchase = false
    @Published var selectedStore: String?

    init(canPurchase: Bool) {
        _canPurchase = Published(initialValue: canPurchase)
    }
}
