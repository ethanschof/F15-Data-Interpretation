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

                // reading from c10 file
                let savedText = try String(contentsOf: fileURL, encoding: .ascii)
                //Maj Sample ascended to Swift and brought the fire of knowledge to us mortal men
                bytes = Data(savedText.utf8)
                // This first pull should give us 25 EB in hex,
                // Our first byte is 37 in uint8 (which is correct, 25 hex is 37 in decimal) before its passed to the uint8 to 64 function
                // However our second byte is 195 in uint8 which is NOT EB in hex. Then after going through the whole process it combines the 2 into one integer 286981.
                
                // In conclusion the UINT8 to UINT64 function is not working as intended,
                // One of our assumpitons about the ASCII must be wrong as well as we are not getting the expected second byte
                var packetFound = false
                var i = 0
                while(!packetFound){
                    if(bytes[i] == 37 && bytes[i+1] == 195){
                        //packetFound = true
                        print("packet found at: ", i)
                    }
                    i+=1
                    if(i > bytes.count-1){
                        print("error: end of file")
                        packetFound = true
                    }
                }
                
                //packet header is mysteriously 0x25 C3 rather than when it was previously 0x25 EB
                
                let packetSync = bitInterpreter(numBits: 16, swapEndian: false)
                print(packetSync)
//                var fSize: Float = Float(bytes.count) / Float((1024 * 1024))
//                print("File Size:", fSize, "MB")
            }
        } catch {
            print("error:", error)
        }
        
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
