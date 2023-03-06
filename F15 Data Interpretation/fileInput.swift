//
//  fileInput.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/23/23.
//

import Foundation

class FileInput : ObservableObject{
    
    var filename: String = "myChap10.ch10"
    var bytes = Data()
    
    var curBitsRead = 0
    var numPkts = 0
    
    //Front-end display data
    @Published var currLeftEngineRPM = 0.0
    @Published var currRightEngineRPM = 0.0
    
    @Published var currLeftEngineTemp = 0.0
    @Published var currRightEngineTemp = 0.0
    
    @Published var currLeftFuelFlow = 0.0
    @Published var currRightFuelFlow = 0.0
    
    @Published var currLeftOilPSI = 0.0
    @Published var currRightOilPSI = 0.0
    
    @Published var currFuelLevel = 0.0
    
    // 4035 cmd wrd attributes
    var trueAirspeed = 0.0
    var aoa = 0.0
    var machNum = 0.0
    var pitchAngle = 0.0
    var rollAngle = 0.0
    var rollRate = 0.0
    var pitchRate = 0.0
    var yawRate = 0.0
    var rollAccel = 0.0
    var pitchAccel = 0.0
    var yawAccel = 0.0
    var longitudinalAccel = 0.0
    var lateralAccel = 0.0
    var rollRateAFCS = 0.0
    var lateralStickForce = 0.0
    var longitudinalStickForce = 0.0
    var rightStabilatorDeflection = 0.0
    var leftStabilatorDeflection = 0.0
    var normalAccel = 0.0
    var sideslipAngle = 0.0
    var dynamicPressure = 0.0
    
    // 4055 cmd wrd attributes
    var leftEngineFuelFlow = 0.0
    var rightEngineFuelFlow = 0.0
    var radarAltitude = 0.0
    var displayTFGCommand = 0.0
    var AFCSTFGCommandValue = 0.0
    
    var radarLowSpeedCaution = false
    var radarJamWarning = false
    var radarNoTerrainWarning = false
    var radarLimitWarning = false
    var radarDiveAngleWarning = false
    var radarTurnAccelWarning = false
    var radarTurnRateWarning = false
    var radarRollAngleWarning = false
    var radarRightTurnCaution = false
    var radarLeftTurnCaution = false
    var radarSetClearanceWarning = false
    var radarGLimitWarning = false
    var radarObstacleWarning = false
    var radarDataGood = false
    var afcsGCommandValid = false
    var displayGCommandValid = false
    var station8PylonPresent = false
    var station5PylonPresent = false
    var station2PylonPresent = false
    var AGMERPresentStation8 = false
    var AGMERPresentRC = false
    var AGMERPresentStation5 = false
    var AGMERPresentLC = false
    var AGMERPresentStation2 = false
    var station8FuelTankPresent = false
    var station5FuelTankPresent = false
    var station2FuelTankPresent = false
    
    var aaWeaponIDStation7 = 0.0
    var aaWeaponIDStation6 = 0.0
    var aaWeaponIDStation4 = 0.0
    var aaWeaponIDStation3 = 0.0
    
    var missileStorePresent7 = false
    var missileStorePresent6 = false
    var missileStorePresent4 = false
    var missileStorePresent3 = false
    var missileStorePresen8B = false
    var missileStorePresent8A = false
    var missileStorePresent2A = false
    var missileStorePresent2B = false
    
    var agWeaponCountStationRC = 0.0
    var agWeaponCountStationLC = 0.0
    var agWeaponCountStation8 = 0.0
    var agWeaponCountStation5 = 0.0
    var agWeaponCountStation2 = 0.0
    
    var MISSING_CODE = 9999999999999.2
    
    
    // 406B cmd wrd attributes
    var casPitchCaution = false
    var casRollCaution = false
    var casYawCaution = false
    var leftBleedAirCaution = false
    var rightBleedAirCaution = false
    var attitudeCaution = false
    
    var pitchRatioCaution = false
    var rollRatioCaution = false
    var emergencyBoostOnCaution = false
    var leftEngineControllerCaution = false
    var rightEngineControllerCaution = false
    var boostSystemMalfunctionCaution = false
    var hydraulicPressureUTILACaution = false
    
    var hydraulicPressurePC1ACaution = false
    var hydraulicPressurePC2Caution = false
    var hydraulicPressureUTILBCaution = false
    var hydraulicPressurePC1BCaution = false
    var hydraulicPressurePC2BCaution = false
    
    var tfrSetClearanceStatus = 0.0
    
    var pressureRatio = 0.0
    var baroCorrectedPressureAltitude = 0.0
    var trueHeading = 0.0
    var verticalVelocity = 0.0
    var landingGearHandleUp = false
    var manualTFConnect = false
    var autoTFConnect = false
    var tfBitInhibited = false
    var modeAFlyUp = false
    var modeBFlyUp = false
    var lowAltitudeMonitorFailed = false
    var afcsDetectedTFFailed = false
    var aftControlStickOverrideIndicated = false
    var highLowAirspeedIndicatorFlashed = false
    
    // 4090 cmd wrd attributes
    
    var leftEngineFanTemp = 0.0
    var leftEngineOilPressure = 0.0
    var leftEngineNozzlePosition = 0.0
    var leftEngineCoreSpeed = 0.0
    var leftEngineFanSpeed = 0.0
    var leftEngineTotalTemp = 0.0
    var leftEnginePowerLevelAngle = 0.0
    var rightEngineFanTemp = 0.0
    var rightEngineOilPressure = 0.0
    var rightEngineNozzlePosition = 0.0
    var rightEngineCoreSpeed = 0.0
    var rightEngineFanSpeed = 0.0
    var rightEngineTotalTemp = 0.0
    var rightEnginePowerLevelAngle = 0.0
    
    var validLeftMachNum = 0.0
    var validLeftDuctFuelFlow = 0.0
    var validLeftCoreFuelFlow = 0.0
    var validLeftGasFuelFlow = 0.0
    var validLeftPowerLeverAngle = 0.0
    var validLeftRCVVPosition = 0.0
    var validLeftCIVVPosition = 0.0
    var validLeftBurnerPressure = 0.0
    var validLeftDischargePressure = 0.0
    var validLeftTotalPressure = 0.0
    var validLeftTotalTemp = 0.0
    var validLeftFanSpeed = 0.0
    var validLeftCoreSpeed = 0.0
    var validLeftNozzlePosition = 0.0
    var validLeftMainOilPressure = 0.0
    var validLeftFanTurbineInletTemp = 0.0
    var validRightMachNum = 0.0
    var validRightDuctFuelFlow = 0.0
    var validRightCoreFuelFlow = 0.0
    var validRightGasFuelFlow = 0.0
    var validRightPowerLeverAngle = 0.0
    var validRightRCVVPosition = 0.0
    var validRightCIVVPosition = 0.0
    var validRightBurnerPressure = 0.0
    var validRightDischargePressure = 0.0
    var validRightTotalPressure = 0.0
    var validRightTotalTemp = 0.0
    var validRightFanSpeed = 0.0
    var validRightCoreSpeed = 0.0
    var validRightNozzlePosition = 0.0
    var validRightMainOilPressure = 0.0
    var validRightFanTurbineInletTemp = 0.0
    
    // 40B0 cmd wrd attributes
    
    var weightOffWheels = false
    var ADCSpikeTrueAOA = false
    var ADCSpikePressureRatio = false
    var ADCSpikeMachNum = false
    var ADCSpikeBaroCorrectedPressAlt = false
    var ADCSpikeNormAcceleration = false
    var ADCDataInvalid = false
    var cumVoiceTimerTimedOut = false
    var MPDPCommInvalid = false
    var SGPNotOperative = false
    var GPNotOperative = false
    var AFCSCommORDataInvalid = false
    var SGPBCommInvalid = false
    var CAUFailure = false
    var solid900Tone = false
    var AOADoubletTone = false
    var intermittent4Tone = false
    var intermittent10Tone = false
    var overloadWarningSystemVMsg = false
    var ASPLatch72 = false
    var fwdFuselageWarningRatio = 0.0
    var wingWarningRatio = 0.0
    var lHorizontalTailWarningRatio = 0.0
    var rHorizontalTailWarningRatio = 0.0
    var pylonWarningRatio = 0.0
    var massItemsWarningRatio = 0.0
    var CFTWarningRatio = 0.0
    var fwdFuselageNZAllowable = 0.0
    var wingNZAllowable = 0.0
    var pylonNZAllowable = 0.0
    var CFTNZAllowable = 0.0
    var time = 0.0
    var timeValid = false
    var sec = 0.0
    var min = 0.0
    var hours = 0.0
    
    // 40D3 cmd wrd attributes
    
    var ipeEngineInstalled = true
    var cftsInstalled = true
    var tewsIDnotStation5 = false
    var invalidArmamentAGcountNoID = false
    var agCountGreaterThan1 = false
    var invalidCFTS = false
    var pacsCommunicationInvalid = false
    var excessFuel = false
    
    var aircraftGrossWeight = 0.0
    var leftCFTfilteredFuelWeight = 0.0
    var rightCFTfilteredFuelWeight = 0.0
    var totalFilteredFuelWeight = 0.0
    
    var yearTensDigit = 0
    var yearOnesDigit = 0
    var monthTensDigit = 0
    var monthOnesDigit = 0
    var dayTensDigit = 0
    var dayOnesDigit = 0
    
    var missionCodeDigit1 = 0
    var missionCodeDigit7 = 0
    
    var acNumberDigit1 = 0
    var acNumberDigit3 = 0
    var acNumberDigit2 = 0
    var acNumberDigit4 = 0
    var acNumberDigit5 = 0
    var acNumberDigit6 = 0
    
    var wingNumberDigit1 = 0
    var wingNumberDigit3 = 0
    var wingNumberDigit2 = 0
    var wingNumberDigit4 = 0
    
    var sfdrIBITControl = true
    var station2TotalWeight = 0.0
    var station8TotalWeight = 0.0
    
    
    // 40E8 cmd wrd attributes
    
    var gcwsStatusDiscretes = 0.0
    var gcwsValidityDiscretes = 0.0
    var gcwsDataReasonableDiscretes = 0.0
    var gcwsHD = 0.0
    var gcwsHM = 0.0
    var gcwsHT = 0.0
    var gcwsHDB = 0.0
    var gcwsNZmax = 0.0
    
    
    
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
            
            var bitsLeftinMsg = (msgLen*8) - 32
            
            switch commandWord {
            case 16437:
                //command word 0x4035
                print("CMD 16437")
                cmd4035(bitsLeft: Int(bitsLeftinMsg))
            case 16469:
                // command word 0x4055
                print("CMD 16469")
                cmd4055(bitsLeft: Int(bitsLeftinMsg))
            case 16491:
                // command word 0x406B
                print("CMD 16491")
                cmd406b(bitsLeft: Int(bitsLeftinMsg))
                
            case 16528:
                // command word 0x4090
                print("CMD 16528")
                cmd4090(bitsLeft: Int(bitsLeftinMsg))
            case 16560:
                // command word 0x40B0
                print("CMD 16560")
                cmd40B0(bitsLeft: Int(bitsLeftinMsg))
            case 16595:
                // command word 0x40D3
                print("CMD 16595")
                cmd40D3(bitsLeft: Int(bitsLeftinMsg))
            case 16616:
                // command word 0x40E8
                print("CMD 16616")
                cmd40E8(bitsLeft: Int(bitsLeftinMsg))

            default:
                print("ERROR: Unknown CMD Word")
                
                var msgData = bitInterpreter(numBits: Int(bitsLeftinMsg), swapEndian: false)
            }
            
            
            
            messagesCompleted += 1
        }
        
    }
    
    func cmd4035(bitsLeft: Int){
        var totalWordsInThisCmdWord = 21
        var bitsInCommandWord = totalWordsInThisCmdWord*16
        
        var temptrueAirspeed = bitInterpreter(numBits: 15, swapEndian: false)
        var valid = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (valid == 1){
            trueAirspeed = Double(temptrueAirspeed)
        }
        
        var tempaoa = bitInterpreter(numBits: 15, swapEndian: false)
        valid = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (valid == 1){
            aoa = Double(tempaoa)
        }
        
        var tempmachNum = bitInterpreter(numBits: 15, swapEndian: false)
        valid = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (valid == 1){
            machNum = Double(tempmachNum)
        }
                
        pitchAngle = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        rollAngle = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        rollRate  = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        pitchRate = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        yawRate = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        rollAccel = Double(bitInterpreter(numBits: 14, swapEndian: false))
        
        var spare = bitInterpreter(numBits: 2, swapEndian: false)
        
        pitchAccel = Double(bitInterpreter(numBits: 12, swapEndian: false))
        spare = bitInterpreter(numBits: 4, swapEndian: false)
        
        yawAccel = Double(bitInterpreter(numBits: 12, swapEndian: false))
        spare = bitInterpreter(numBits: 4, swapEndian: false)
        
        longitudinalAccel = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        lateralAccel = Double(bitInterpreter(numBits: 16, swapEndian: false))
        rollRateAFCS = Double(bitInterpreter(numBits: 16, swapEndian: false))
        lateralStickForce = Double(bitInterpreter(numBits: 16, swapEndian: false))
        longitudinalStickForce = Double(bitInterpreter(numBits: 16, swapEndian: false))
        rightStabilatorDeflection = Double(bitInterpreter(numBits: 16, swapEndian: false))
        leftStabilatorDeflection = Double(bitInterpreter(numBits: 16, swapEndian: false))
        normalAccel = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        var tempsideslipAngle = Double(bitInterpreter(numBits: 15, swapEndian: false))
        valid = bitInterpreter(numBits: 1, swapEndian: false)
        if (valid == 1){
            sideslipAngle = Double(tempsideslipAngle)
        }
        
        dynamicPressure = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        if (bitsInCommandWord < bitsLeft){
            var difference = bitsLeft - bitsInCommandWord
            var junk = bitInterpreter(numBits: difference, swapEndian: false)
        } else if (bitsInCommandWord > bitsLeft) {
            print("there are more bits in the command word than were left in the message, something is wrong :(")
        }
        
    }
    
    func cmd4055(bitsLeft: Int){
        
        var totalWordsInThisCmdWord = 16
        // multiply by 16 because all the words are 16 bits in this cmdwrd
        var bitsInCommandWord = totalWordsInThisCmdWord*16
        
         leftEngineFuelFlow = Double(bitInterpreter(numBits: 16, swapEndian: false))
         rightEngineFuelFlow = Double(bitInterpreter(numBits: 16, swapEndian: false))
         radarAltitude = Double(bitInterpreter(numBits: 16, swapEndian: false))
         displayTFGCommand = Double(bitInterpreter(numBits: 16, swapEndian: false))
         AFCSTFGCommandValue = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        var bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarLowSpeedCaution = true
        } else {
            radarLowSpeedCaution = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarJamWarning = true
        } else {
            radarJamWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarNoTerrainWarning = true
        } else {
            radarNoTerrainWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarLimitWarning = true
        } else {
            radarLimitWarning = false
        }
         
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarLimitWarning = true
        } else {
            radarLimitWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarDiveAngleWarning = true
        } else {
            radarDiveAngleWarning = false
        }

        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarTurnAccelWarning = true
        } else {
            radarTurnAccelWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarTurnRateWarning = true
        } else {
            radarTurnRateWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarRollAngleWarning = true
        } else {
            radarRollAngleWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarRightTurnCaution = true
        } else {
            radarRightTurnCaution = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarLeftTurnCaution = true
        } else {
            radarLeftTurnCaution = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarSetClearanceWarning = true
        } else {
            radarSetClearanceWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarGLimitWarning = true
        } else {
            radarGLimitWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarObstacleWarning = true
        } else {
            radarObstacleWarning = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            radarDataGood = true
        } else {
            radarDataGood = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            afcsGCommandValid = true
        } else {
            afcsGCommandValid = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            displayGCommandValid = true
        } else {
            displayGCommandValid = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station8PylonPresent = true
        } else {
            station8PylonPresent = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station5PylonPresent = true
        } else {
            station5PylonPresent = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station2PylonPresent = true
        } else {
            station2PylonPresent = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            AGMERPresentStation8 = true
        } else {
            AGMERPresentStation8 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            AGMERPresentRC = true
        } else {
            AGMERPresentRC = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            AGMERPresentStation5 = true
        } else {
            AGMERPresentStation5 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            AGMERPresentLC = true
        } else {
            AGMERPresentLC = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            AGMERPresentStation2 = true
        } else {
            AGMERPresentStation2 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station8FuelTankPresent = true
        } else {
            station8FuelTankPresent = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station5FuelTankPresent = true
        } else {
            station5FuelTankPresent = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            station2FuelTankPresent = true
        } else {
            station2FuelTankPresent = false
        }
        
         bitInterpreter(numBits: 3, swapEndian: false)
        
         aaWeaponIDStation7 = Double(bitInterpreter(numBits: 2, swapEndian: false))
         aaWeaponIDStation6 = Double(bitInterpreter(numBits: 2, swapEndian: false))
         aaWeaponIDStation4 = Double(bitInterpreter(numBits: 2, swapEndian: false))
         aaWeaponIDStation3 = Double(bitInterpreter(numBits: 2, swapEndian: false))
        
        bitInterpreter(numBits: 2, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent7 = true
        } else {
            missileStorePresent7 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent6 = true
        } else {
            missileStorePresent6 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent4 = true
        } else {
            missileStorePresent4 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent3 = true
        } else {
            missileStorePresent3 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresen8B = true
        } else {
            missileStorePresen8B = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent8A = true
        } else {
            missileStorePresent8A = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent2A = true
        } else {
            missileStorePresent2A = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            missileStorePresent2B = true
        } else {
            missileStorePresent2B = false
        }
        
         agWeaponCountStationRC = Double(bitInterpreter(numBits: 16, swapEndian: false))
         agWeaponCountStationLC = Double(bitInterpreter(numBits: 16, swapEndian: false))
         agWeaponCountStation8 = Double(bitInterpreter(numBits: 16, swapEndian: false))
         agWeaponCountStation5 = Double(bitInterpreter(numBits: 16, swapEndian: false))
         agWeaponCountStation2 = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        
        
        
        
        if (bitsInCommandWord < bitsLeft){
            var difference = bitsLeft - bitsInCommandWord
            var junk = bitInterpreter(numBits: difference, swapEndian: false)
        } else if (bitsInCommandWord > bitsLeft) {
            print("there are more bits in the command word than were left in the message, something is wrong :(")
        }
    } // end of cmd4055 function
    
    func cmd406b(bitsLeft: Int){
        var totalWordsInThisCmdWord = 11
        // multiply by 16 because all the words are 16 bits in this cmdwrd
        var bitsInCommandWord = totalWordsInThisCmdWord*16
        
        var trash = bitInterpreter(numBits: 1, swapEndian: false)
        var bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            casPitchCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            casRollCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            casYawCaution = true
        }
        trash = bitInterpreter(numBits: 3, swapEndian: false)
        trash = bitInterpreter(numBits: 4, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            leftBleedAirCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            rightBleedAirCaution = true
            
        }
        trash = bitInterpreter(numBits: 1, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            attitudeCaution = true
        }
        
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            pitchRatioCaution = true
            
        }
        
        trash = bitInterpreter(numBits: 4, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            rollRatioCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            emergencyBoostOnCaution = true
        }
        
        trash = bitInterpreter(numBits: 5, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            leftEngineControllerCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            rightEngineControllerCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            boostSystemMalfunctionCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressureUTILACaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressurePC1ACaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressurePC2Caution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressureUTILBCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressurePC1BCaution = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            hydraulicPressurePC2BCaution = true
        }
        
        trash = bitInterpreter(numBits: 1, swapEndian: false)
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        trash = bitInterpreter(numBits: 6, swapEndian: false)
        
        tfrSetClearanceStatus = Double(bitInterpreter(numBits: 3, swapEndian: false))
        
        var tempPressure = bitInterpreter(numBits: 15, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if (bit == 1){
            pressureRatio = Double(tempPressure)
        }
        
        baroCorrectedPressureAltitude = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        trueHeading = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        verticalVelocity = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        trash = bitInterpreter(numBits: 5, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            landingGearHandleUp = true
        }
        trash = bitInterpreter(numBits: 2, swapEndian: false)
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            manualTFConnect = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            autoTFConnect = true
        }
        
        trash = bitInterpreter(numBits: 6, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            tfBitInhibited = true
        }
        
        trash = bitInterpreter(numBits: 2, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            modeAFlyUp = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            modeBFlyUp = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            lowAltitudeMonitorFailed = true
        }
        
        trash = bitInterpreter(numBits: 3, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            afcsDetectedTFFailed = true
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            aftControlStickOverrideIndicated = true
        }
        
        trash = bitInterpreter(numBits: 2, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            highLowAirspeedIndicatorFlashed = true
        }
        
        if (bitsInCommandWord < bitsLeft){
            var difference = bitsLeft - bitsInCommandWord
            var junk = bitInterpreter(numBits: difference, swapEndian: false)
        } else if (bitsInCommandWord > bitsLeft) {
            print("there are more bits in the command word than were left in the message, something is wrong :(")
        }
    } // end of cmd406b function
    
    func cmd4090(bitsLeft: Int){}
    
    func cmd40B0(bitsLeft: Int){}
    
    func cmd40D3(bitsLeft: Int){
        var totalWordsInThisCmdWord = 22
        // multiply by 16 because thats how many bytes there are in this cmd wrd
        var bitsInCommandWord = totalWordsInThisCmdWord*16
        
        var bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            ipeEngineInstalled = true
        } else {
            ipeEngineInstalled = false
        }
        
        var trash = bitInterpreter(numBits: 15, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            cftsInstalled = true
        } else {
            cftsInstalled = false
        }
        
        trash = bitInterpreter(numBits: 15, swapEndian: false)
        
        trash = bitInterpreter(numBits: 10, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            tewsIDnotStation5 = true
        } else {
            tewsIDnotStation5 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            invalidArmamentAGcountNoID = true
        } else {
            invalidArmamentAGcountNoID = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            agCountGreaterThan1 = true
        } else {
            agCountGreaterThan1 = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            invalidCFTS = true
        } else {
            invalidCFTS = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            pacsCommunicationInvalid = true
        } else {
            pacsCommunicationInvalid = false
        }
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        
        if (bit == 1){
            excessFuel = true
        } else {
            excessFuel = false
        }
       
        
        aircraftGrossWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
        leftCFTfilteredFuelWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
        rightCFTfilteredFuelWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
        totalFilteredFuelWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
       
        yearTensDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        yearOnesDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        monthTensDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        monthOnesDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 16, swapEndian: false)
        
        dayTensDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        dayOnesDigit = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
       
        missionCodeDigit1 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        missionCodeDigit7 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
       
        acNumberDigit1 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        acNumberDigit3 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        acNumberDigit2 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        acNumberDigit4 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        acNumberDigit5 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        acNumberDigit6 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
       
        wingNumberDigit1 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        wingNumberDigit3 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        wingNumberDigit2 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        wingNumberDigit4 = Int(bitInterpreter(numBits: 4, swapEndian: false))
        
        trash = bitInterpreter(numBits: 8, swapEndian: false)
        
        bit = bitInterpreter(numBits: 1, swapEndian: false)
        if(bit == 1){
            sfdrIBITControl = true
        } else {
            sfdrIBITControl = false
        }
        
        station2TotalWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
        station8TotalWeight = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        
        if (bitsInCommandWord < bitsLeft){
            var difference = bitsLeft - bitsInCommandWord
            var junk = bitInterpreter(numBits: difference, swapEndian: false)
        } else if (bitsInCommandWord > bitsLeft) {
            print("there are more bits in the command word than were left in the message, something is wrong :(")
        }
    } // end of cmd40D3()
    
    func cmd40E8(bitsLeft: Int){
        var totalWordsInThisCmdWord = 8
        // multiply by 16 because all the words are 16 bits in this cmdwrd
        var bitsInCommandWord = totalWordsInThisCmdWord*16
        
        gcwsStatusDiscretes = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsValidityDiscretes = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsDataReasonableDiscretes = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsHD = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsHM = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsHT = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsHDB = Double(bitInterpreter(numBits: 16, swapEndian: false))
        gcwsNZmax = Double(bitInterpreter(numBits: 16, swapEndian: false))
        
        if (bitsInCommandWord < bitsLeft){
            var difference = bitsLeft - bitsInCommandWord
            var junk = bitInterpreter(numBits: difference, swapEndian: false)
        } else if (bitsInCommandWord > bitsLeft) {
            print("there are more bits in the command word than were left in the message, something is wrong :(")
        }
        
    } // end of cmd40E8()
    
}
