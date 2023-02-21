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
    var numPkts = 0
    
    
    //reads in file into byte array
    func FileInput(name: String) {
        self.filename = name
        do {
            // get the documents folder url
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent(self.filename)
                
                bytes = try Data(contentsOf: fileURL)

                fileInfo()
                //parseHeader()
            }
        } catch {
            print("error:", error)
        }
        
    }
    
    //displays information about the read-in data
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
    }
    
    //converts byte array into UInt64
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
    
    //removes number of bits from byte array and returns their integer value
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
            
            curBitsRead = (curBitsRead + numBits % 8)%8
            
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
    
    //removes number of bytes from byte array and returns them
    func sliceByteArray (numBits : Int, swapEndian : Bool) -> [UInt8]{
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
        
        return pulledBytes
    }
    
    /**
        Parse Header
        Uses the class variable bytes to interpret each of the packet headers and call 1553 packets to be interpretted further
     **/
    func parseHeader() {
        while(bytes.count > 1){
            var pktSync = bitInterpreter(numBits: 16, swapEndian: false)
            var channelID = bitInterpreter(numBits: 16, swapEndian: true)
            var pktLength = bitInterpreter(numBits: 32, swapEndian: true)
            var dataLength = bitInterpreter(numBits: 32, swapEndian: true)
            var dataTypeVer = bitInterpreter(numBits: 8, swapEndian: true)
            var sequenceNum = bitInterpreter(numBits: 8, swapEndian: true)
            var pktFlags = bitInterpreter(numBits: 8, swapEndian: true)
            var dataType = bitInterpreter(numBits: 8, swapEndian: false)
            var relativeTimeCount = bitInterpreter(numBits: 48, swapEndian: true)
            var headerChecksum = bitInterpreter(numBits: 16, swapEndian: true)
            numPkts += 1
            
            if(dataType == 25){
                parseCMDHeader(pktLen: pktLength)
            }else{
                //overloaded version of bitInterpreter that returns an array of UInt8 rather than a UInt64
                //ignore non-1553 message data
                var packetData: [UInt8] = sliceByteArray(numBits: Int(pktLength*8 - 192), swapEndian: false)
            }
            //print values
            /*print("1553 Packet Number: ", numPkts)
            print("========================")
            print("Sync: ", pktSync)
            print("Channel ID: ", channelID)
            print("Packet Length: ", pktLength)
            print("Data Length: ", dataLength)
            print("Data Type Version: ", dataTypeVer)
            print("Sequence Number: ", sequenceNum)
            print("Packet Flags: ", pktFlags)
            print("Data Type: ", dataType)
            print("Time Count: ", relativeTimeCount)
            print("Header Checksum: ", headerChecksum)
            print("========================\n")*/
        }
    }
    
    func parseCMDHeader(pktLen: UInt64) {
        
    }
}
