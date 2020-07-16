//
//  SelectServiceView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI

struct Service: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Decimal
    let duration: TimeInterval

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: price as NSNumber) ?? "Free"
    }

    static let example = Bundle.main.decode([Service].self, from: "services.json")[0]
}

struct SelectServiceView: View {
    let services = Bundle.main.decode([Service].self, from: "services.json")
    let store: Store

    var body: some View {
        List(services) { service in
            NavigationLink(destination: PurchaseView(store: store, service: service)) {
                VStack(alignment: .leading) {
                    Text(service.name)
                        .font(.title)
                    Text(service.description)

                    HStack {
                        Text("Ready by: ")
                            .bold() +
                            Text(Date().addingTimeInterval(service.duration), style: .time)

                        Spacer()

                        Text(service.formattedPrice)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding(5)
                    }
                }
                .padding()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(store.name)
    }
}

struct SelectServiceView_Previews: PreviewProvider {
    static var previews: some View {
        SelectServiceView(store: Store.example)
    }
}
