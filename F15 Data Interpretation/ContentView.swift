//
//  ContentView.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    var maxEngineRPM = 150.0
    var minEngineRPM = 0.0
    @State private var currLeftEngineRPM = 75.0
    @State private var currRightEngineRPM = 75.0
    
    var minEngineTemp = 0.0
    var maxEngineTemp = 1200.0
    @State private var currLeftEngineTemp = 1000.0
    @State private var currRightEngineTemp = 1100.0
    
    var minFuelFlow = 0.0
    var maxFuelFlow = 60000.0
    @State private var currLeftFuelFlow = 5342.3
    @State private var currRightFuelFlow = 57842.1
    
    var minOilPSI = 1.0
    var maxOilPSI = 100.0
    @State private var currLeftOilPSI = 14.0
    @State private var currRightOilPSI = 96.0
    
    
    var body: some View {
        VStack {
            
            Text("Engine Data")
                .font(.headline)
                .scaleEffect(3.0)
                .padding(.all, 60.0)
            
            
            // Engine Horizontal Stack
            HStack{
                Spacer()
                // Left engine
                VStack{
                    
                    Text("Left Engine").fontWeight(.semibold)
                        .scaleEffect(1.4)
                    
                    // RPM Guage
                    Gauge(value: currLeftEngineRPM, in: minEngineRPM...maxEngineRPM) {
                      Text("RPM")
                    } currentValueLabel: {
                        Text(currLeftEngineRPM.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)
                    
                    
                    // Engine Temperature Guage
                    Gauge(value: currLeftEngineTemp, in: minEngineTemp...maxEngineTemp) {
                      Text("Left Engine Temperature").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(currLeftEngineTemp.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    } minimumValueLabel: {
                      Text(minEngineTemp.formatted())
                    } maximumValueLabel: {
                      Text(maxEngineTemp.formatted())
                    }
                    .padding(.all)
                    
                    
                    Text("Fuel Flow")
                        .fontWeight(.semibold)
                        .scaleEffect(1.4)
                    
                    Gauge(value: currLeftFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(currLeftFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)
                    
                    // Left Oil PSI
                    Gauge(value: currLeftOilPSI, in: minOilPSI...maxOilPSI) {
                      Text("Right Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(currLeftOilPSI.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)
                    
                    
                }.padding(.all) // End of  Left Engine
                
                Spacer()
                
                VStack{
                    Text("Right Engine").fontWeight(.semibold)
                        .scaleEffect(1.4)
                    
                    // RPM Guage
                    Gauge(value: currRightEngineRPM, in: minEngineRPM...maxEngineRPM) {
                      Text("RPM")
                    } currentValueLabel: {
                        Text(currRightEngineRPM.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)
                    
                    // Engine Temperature Guage
                    Gauge(value: currLeftEngineTemp, in: minEngineTemp...maxEngineTemp) {
                      Text("Right Engine Temperature").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(currLeftEngineTemp.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    } minimumValueLabel: {
                      Text(minEngineTemp.formatted())
                    } maximumValueLabel: {
                      Text(maxEngineTemp.formatted())
                    }
                    .padding(.all)
                    
                    Text("Right Engine Fuel Flow")
                        .fontWeight(.semibold)
                        .scaleEffect(1.2)
                    
                    Gauge(value: currRightFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(currRightFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)
                    
                    // Right Oil PSI
                    Gauge(value: currRightOilPSI, in: minOilPSI...maxOilPSI) {
                      Text("Right Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(currRightOilPSI.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)
                    
                    
                }
                .padding(.all) // End of Right Engine
                
                Spacer()
            } // End of Engine HStack
            
            Text("Total Fuel")
                .font(.title2)
                .scaleEffect(1.5)

            Gauge(value: currLeftEngineTemp, in: minEngineTemp...maxEngineTemp) {
            } currentValueLabel: {
                Text(currLeftEngineTemp.formatted())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            } minimumValueLabel: {
              Text("E")
            } maximumValueLabel: {
              Text("F")
            }
            .padding(.all)
            
            
            
        } // End of Overall VStack
    } // End of Body
} // End of content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
