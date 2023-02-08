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
                var fSize: Float = Float(bytes.count) / Float((1024 * 1024))
                print("File Size:", fSize, "MB")
            }
        } catch {
            print("error:", error)
        }
        
    }
    s
    func bytesToUInt64(byteArray: [UInt8], length : Int) -> UInt64 {
        var total: UInt64 = 0
        var power = 0.0
        for byte in byteArray.reversed() {
            for i in (0...7){
                var mask = UInt64(byte & 1 << i) * UInt64(pow(2, power))
                total = UInt64(total + mask)
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
        
        var returnVal: UInt64 = bytesToUInt64(byteArray: pulledBytes, length: numBytes)
        return returnVal
    }
    
    func parseHeader() {
        
    }
}
