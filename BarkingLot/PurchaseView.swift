//
//  PurchaseView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var model: DataModel
    @State private var orderPlaced = false
    let store: Store
    let service: Service

    var body: some View {
        Form {
            Section {
                Text("Store: \(store.name)")
                Text("Address: \(store.address)")
                Text("Service: \(service.name)")
                Text("Price: \(service.formattedPrice)")
            }

            Section {
                (Text("Ready by: ") + Text(Date().addingTimeInterval(service.duration), style: .time))
                    .bold()
            }

            if orderPlaced {
                Text("Thank you!")
                    .font(.largeTitle)

                Text("See you soon!")
            } else {
                Section(footer:
                    model.canPurchase == false
                    ? AnyView(Text("Sorry, you need to be in or near this store to make a booking."))
                    : AnyView(EmptyView())
                ) {
                    Button("Reserve ") {
                        orderPlaced = true
                    }
                }
                .disabled(model.canPurchase == false)
            }
        }
        .navigationTitle("Confirmation")
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(store: Store.example, service: Service.example)
    }
}
