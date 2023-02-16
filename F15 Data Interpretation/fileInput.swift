//
//  fileInput.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/23/23.
//

import Foundation

class FileInput {
    
    var filename: String = "myChap10.ch10"
    var bytes = Data()
    
    var curBitsRead = 0
    
    
    func FileInput(name: String) {
        self.filename = name
        do {
            // get the documents folder url
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent(self.filename)
                
                bytes = try Data(contentsOf: fileURL)


                fileInfo()
                
                
                let packetSync = bitInterpreter(numBits: 16, swapEndian: false)
                print(packetSync)
                
                
            }
        } catch {
            print("error:", error)
        }
        
    }
    func fileInfo(){
        var packetFound = false
        var i = 0
        var numPackets = 0
        while(!packetFound){
            if(bytes[i] == 37 && bytes[i+1] == 235){
                //packetFound = true
                //print("packet found at: ", i)
                numPackets += 1
            }
            i+=1
            if(i > bytes.count-1){
                print("end of file")
                packetFound = true
            }
        }
        print("Approximate number of packets : ", numPackets)
        
        let fSize: Float = Float(bytes.count) / Float((1024 * 1024))
        print("File Size:", fSize, "MB")
        //packet header is mysteriously 0x25 C3 rather than when it was previously 0x25 EB
    }
    func bytesToUInt64(byteArray: [UInt8], length : Int) -> UInt64 {
        var total: UInt64 = 0
        var power = 0.0
        for byte in byteArray.reversed() {
            for i in (0...7){
                let mask = UInt64((byte >> i) & 1)
                let cur = mask * UInt64(pow(2, power))
                total = UInt64(total + cur)
                power += 1
            }
        }
        return total
    }
    
    func bitInterpreter(numBits : Int, swapEndian : Bool) -> UInt64{
        var numBytes = numBits / 8
        var onlyBytes = true
        if(numBits % 8 != 0){
            numBytes += 1
            onlyBytes = false
        }
        
        var pulledBytes = [UInt8]()
        
        if(onlyBytes){
            while(numBytes != 0){
                pulledBytes.append(bytes.removeFirst())
                numBytes -= 1
            }
        }else{
            
            while(numBytes != 1){
                pulledBytes.append(bytes.removeFirst())
                numBytes -= 1
            }
            
            //remove unwanted bits
            pulledBytes.append(bytes.first!)
            pulledBytes[pulledBytes.lastIndex(of: pulledBytes.last!)!] = pulledBytes.last! >> (8 - numBits%8)
            
            if((curBitsRead + numBits%8)%8 == 0){
                bytes.removeFirst()
            }else{
                //remove requested bits off the byte function
                bytes[bytes.firstIndex(of: pulledBytes.first!)!] = pulledBytes.first! << (numBits%8)
            }
        }
        
        //swap endian of pulledBytes if true
        if(swapEndian){
            pulledBytes.reverse()
        }
        
        let returnVal: UInt64 = bytesToUInt64(byteArray: pulledBytes, length: numBytes)
        return returnVal
    }
    
    func parseHeader() {
        
    }
}
