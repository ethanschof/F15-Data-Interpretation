//
//  ContentView.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/19/23.
//

import SwiftUI

// https://useyourloaf.com/blog/swiftui-gauges/

struct ContentView: View {
    @StateObject private var f = FileInput()
    func onClick(){
        f.FileInput(name: "myChap10.ch10")
        
    }
    
    func parseOneHeader(){
        f.parseHeader()
    }
    
    var maxEngineRPM = 150.0
    var minEngineRPM = 0.0
    
    var minEngineTemp = 0.0
    var maxEngineTemp = 1200.0
    
    var minFuelFlow = 0.0
    var maxFuelFlow = 60000.0
    
    var minOilPSI = 1.0
    var maxOilPSI = 100.0
    
    var emptyFuel = 0.0
    var fullFuel = 100.0
    
    
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
                    Gauge(value: f.currLeftEngineRPM, in: minEngineRPM...maxEngineRPM) {
                      Text("RPM")
                    } currentValueLabel: {
                        Text(f.currLeftEngineRPM.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)


                    // Engine Temperature Guage
                    Gauge(value: f.currLeftEngineTemp, in: minEngineTemp...maxEngineTemp) {
                      Text("Left Engine Temperature").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.currLeftEngineTemp.formatted())
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

                    Gauge(value: f.currLeftFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(f.currLeftFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Left Oil PSI
                    Gauge(value: f.currLeftOilPSI, in: minOilPSI...maxOilPSI) {
                      Text("Right Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.currLeftOilPSI.formatted())
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
                    Gauge(value: f.currRightEngineRPM, in: minEngineRPM...maxEngineRPM) {
                      Text("RPM")
                    } currentValueLabel: {
                        Text(f.currRightEngineRPM.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Engine Temperature Guage
                    Gauge(value: f.currRightEngineTemp, in: minEngineTemp...maxEngineTemp) {
                      Text("Right Engine Temperature").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.currRightEngineTemp.formatted())
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

                    Gauge(value: f.currRightFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(f.currRightFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Right Oil PSI
                    Gauge(value: f.currRightOilPSI, in: minOilPSI...maxOilPSI) {
                      Text("Right Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.currRightOilPSI.formatted())
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

            Gauge(value: f.currFuelLevel, in: emptyFuel...fullFuel) {
            } currentValueLabel: {
                Text(f.currFuelLevel.formatted())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            } minimumValueLabel: {
              Text("E")
            } maximumValueLabel: {
              Text("F")
            }
            .padding(.all)
            
            Button(action: onClick){
                Text("Open File")
            }
            
            Button(action: parseOneHeader){
                Text("Parse header")
            }.padding(.all)
            
        } // End of Overall VStack
    } // End of Body
} // End of content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
