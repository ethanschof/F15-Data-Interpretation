//
//  F15_Data_InterpretationApp.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/19/23.
//

import SwiftUI

@main
struct F15_Data_InterpretationApp: App {
    var connect = TCPClient(ipAddress: "127.0.0.1", portNumber: "20230")
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
