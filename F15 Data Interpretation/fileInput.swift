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
    
    //Front-end display data
    var currLeftEngineRPM = 0.0
    var currRightEngineRPM = 0.0
    
    var currLeftEngineTemp = 0.0
    var currRightEngineTemp = 0.0
    
    var currLeftFuelFlow = 0.0
    var currRightFuelFlow = 0.0
    
    var currLeftOilPSI = 0.0
    var currRightOilPSI = 0.0
    
    var currFuelLevel = 0.0
    
    
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
                currFuelLevel = 60
            }
        } catch {
            print("error:", error)
        }
        
        //print(bitInterpreter(numBits: 3, swapEndian: false))
        //print(bitInterpreter(numBits: 4, swapEndian: false))
        //print(bitInterpreter(numBits: 1, swapEndian: false))
        
        print(bitInterpreter(numBits: 15, swapEndian: false))
        print(bitInterpreter(numBits: 1, swapEndian: false))
        
        
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
        
        var bitsMod8 = numBits%8
        
        if(bitsMod8 != 0){
            numBytes += 1
            onlyBytes = false
        }
        
        var pulledBytes = [UInt8]()
        
        if(onlyBytes){
            var i = numBytes
            while(i != 0){
                pulledBytes.append(bytes.removeFirst())
                i -= 1
            }
        }else{
            var i = numBytes
            while(i != 1){
                pulledBytes.append(bytes.removeFirst())
                i -= 1
            }
            
            //remove unwanted bits
            pulledBytes.append(bytes.first!)
            pulledBytes[pulledBytes.lastIndex(of: pulledBytes.last!)!] = pulledBytes.last! >> (8 - bitsMod8)
            
            if((curBitsRead + bitsMod8)%8 == 0){
                bytes.removeFirst()
            }else{
                //remove requested bits off the byte function
                bytes[bytes.startIndex] = bytes[bytes.startIndex] << (bitsMod8)
            }
            curBitsRead = (curBitsRead + bitsMod8)%8
            
            if(numBytes == 2){
                var a = pulledBytes[0] << (bitsMod8)
                pulledBytes[1] = pulledBytes[1] | a
                pulledBytes[0] = pulledBytes[0] >> (8-bitsMod8)
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
            print("1553 Packet Number: ", numPkts)
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
            print("========================\n")
        }
    }
    
    func parseCMDHeader(pktLen: UInt64) {
        var messageCount = bitInterpreter(numBits: 24, swapEndian: false)
        
        var chanSpecData = bitInterpreter(numBits: 8, swapEndian: false)
        
        var messagesCompleted = 0
        
        while(messageCount < messagesCompleted){
            var intraPacketTimeStamp = bitInterpreter(numBits: 64, swapEndian: false)
            var blockStatusWord = bitInterpreter(numBits: 16, swapEndian: true)
            var gapTimesWord = bitInterpreter(numBits: 16, swapEndian: true)
            
            var msgLen = bitInterpreter(numBits: 16, swapEndian: false)
            
            var commandWord = bitInterpreter(numBits: 16, swapEndian: true)
            
            var secondWord = bitInterpreter(numBits: 16, swapEndian: false)
            
            switch commandWord {
            case 16437:
                //command word 0x4035
                print("CMD 16437")
            case 16469:
                // command word 0x4055
                print("CMD 16469")
            case 16491:
                // command word 0x406B
                print("CMD 16491")
            case 16528:
                // command word 0x4090
                print("CMD 16528")
            case 16560:
                // command word 0x40B0
                print("CMD 16560")
            case 16595:
                // command word 0x40D3
                print("CMD 16595")
            case 16616:
                // command word 0x40E8
                print("CMD 16616")

            default:
                print("ERROR: Unknown CMD Word")
                var bitsLeftinMsg = (msgLen*8) - 32
                var msgData = bitInterpreter(numBits: Int(bitsLeftinMsg), swapEndian: false)
            }
            
            
            
            messagesCompleted += 1
        }
        
    }
    
    
}
