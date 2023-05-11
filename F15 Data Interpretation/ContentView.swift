//
//  ContentView.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/19/23.
//

import SwiftUI

// https://useyourloaf.com/blog/swiftui-gauges/

struct ContentView: View {
    @StateObject var tcp = TCPClient()
    
    
    
    @StateObject private var f = FileInput()
    func onClick(){
        f.FileInput(name: "myChap10.ch10")
        
    }
    
    func parseOneHeader(){
        f.parseHeader()
    }
    
    var maxEngineRPM = 150000.0
    var minEngineRPM = 0.0
    
    var minEngineTemp = 0.0
    var maxEngineTemp = 70000.0
    
    var minFuelFlow = 0.0
    var maxFuelFlow = 60000.0
    
    var minOilPSI = 1.0
    var maxOilPSI = 100000.0
    
    var emptyFuel = 0.0
    var fullFuel = 100000.0
    
    
    var body: some View {
        VStack {
            
            Text("F15 Data")
                .font(.headline)
                .scaleEffect(3.0)
                .padding(.all, 60.0)
            
            
            // Engine Horizontal Stack
            HStack{
                Spacer()
                // Left engine
                VStack{

                    Text("Pitch Angle").fontWeight(.semibold)
                        .scaleEffect(1.4)

                    // RPM Guage
                    Gauge(value: f.pitchAngle, in: minEngineRPM...maxEngineRPM) {
                      Text("Degs")
                    } currentValueLabel: {
                        Text(f.pitchAngle.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)


                    // Engine Temperature Guage
                    Gauge(value: f.rollAngle, in: minEngineTemp...maxEngineTemp) {
                      Text("Roll Angle").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.rollAngle.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    } minimumValueLabel: {
                      Text(minEngineTemp.formatted())
                    } maximumValueLabel: {
                      Text(maxEngineTemp.formatted())
                    }
                    .padding(.all)


                    Text("Left Engine Fuel Flow")
                        .fontWeight(.semibold)
                        .scaleEffect(1.4)

                    Gauge(value: f.leftEngineFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(f.leftEngineFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Left Oil PSI
                    Gauge(value: f.leftEngineOilPressure, in: minOilPSI...maxOilPSI) {
                      Text("Left Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.leftEngineOilPressure.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)


                }.padding(.all) // End of  Left Engine

                Spacer()

                VStack{
                    Text("Yaw Rate").fontWeight(.semibold)
                        .scaleEffect(1.4)

                    // RPM Guage
                    Gauge(value: f.yawRate, in: minEngineRPM...maxEngineRPM) {
                      Text("Degs")
                    } currentValueLabel: {
                        Text(f.yawRate.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Engine Temperature Guage
                    Gauge(value: f.rollAccel, in: minEngineTemp...maxEngineTemp) {
                      Text("Roll Accelleration").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.rollAccel.formatted())
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

                    Gauge(value: f.rightEngineFuelFlow, in: minFuelFlow...maxFuelFlow) {
                      Text("PPH")
                    } currentValueLabel: {
                        Text(f.rightEngineFuelFlow.formatted())
                    }
                    .gaugeStyle(.accessoryCircular)
                    .scaleEffect(2)
                    .padding(.all, 40.0)

                    // Right Oil PSI
                    Gauge(value: f.rightEngineOilPressure, in: minOilPSI...maxOilPSI) {
                      Text("Right Engine Oil PSI").fontWeight(.semibold)
                            .scaleEffect(1.2)
                    } currentValueLabel: {
                        Text(f.rightEngineOilPressure.formatted())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)


                }
                .padding(.all) // End of Right Engine

                Spacer()
            } // End of Engine HStack
            
            Text("Total Fuel Weight")
                .font(.title2)
                .scaleEffect(1.5)

            Gauge(value: f.totalFilteredFuelWeight, in: emptyFuel...fullFuel) {
            } currentValueLabel: {
                Text(f.totalFilteredFuelWeight.formatted())
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            } minimumValueLabel: {
              Text("E")
            } maximumValueLabel: {
              Text("F")
            }
            .padding(.all)
            
            VStack {
                        Button("Connect") {
                            tcp.connect(host: "10.192.78.249", port: 2023)
                        }
                        Button("Disconnect") {
                            tcp.disconnect()
                        }
                    }
                    .onReceive(tcp.$receivedPacket) { packet in
                        if let packet = packet {
                            f.parsePacket(packet: packet)
                        }
                    }
            
//            Button(action: onClick){
//                Text("Open File")
//            }
//
//            Button(action: parseOneHeader){
//                Text("Parse header")
//            }.padding(.all)
            
        } // End of Overall VStack
    } // End of Body
} // End of content view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
