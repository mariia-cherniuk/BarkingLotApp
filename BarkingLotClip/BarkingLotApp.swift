//
//  BarkingLotApp.swift
//  BarkingLotClip
//
//  Created by Mariia Cherniuk on 16/07/2020.
//

import SwiftUI
import AppClip
import CoreLocation

extension Array where Element == URLQueryItem {
    
    func value(for name: String) -> String? {
        first(where: {$0.name == name})?.value
    }
}

@main
struct BarkingLotClipApp: App {
    
    @StateObject var model = DataModel(canPurchase: false)
    
    func handleActivity(_ userActivity: NSUserActivity) {
        guard let url = userActivity.webpageURL else { return }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        guard let queryItems = components.queryItems else { return }
        
        if let storeID = queryItems.value(for: "store") {
            model.selectedStore = storeID
        }
 
        
        guard let payload = userActivity.appClipActivationPayload,
            let lat = queryItems.value(for: "latitude"),
        let lon = queryItems.value(for: "longitude"),
        let latitude = Double(lat), let longitude = Double(lon) else { return }
        
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: 100, identifier:"location")
 
        payload.confirmAcquired(in: region, completionHandler: { inRegion, error in
            if let error = error as? APActivationPayloadError {
                if error.code == APActivationPayloadError.disallowed {
                    print ("Not launched by visual code")
                } else if error.code == APActivationPayloadError.doesNotMatch {
                    print ("Region does not match location")
                } else {
                    print (error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    model.canPurchase = inRegion
                }
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SelectStoreView()
            }
            .environmentObject(model)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform:handleActivity)
        }
    }
}
