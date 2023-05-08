//
//  TCP Client.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 5/8/23.
//

import Foundation
import Network
import SwiftUI

func hexString(from data: Data) -> String {
    return data.map { String(format: "%02x", $0) }.joined()
}

class TCPClient: NSObject, ObservableObject {
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    private var receiveBuffer = Data()
    
    @Published var receivedPacket: Data? = nil
    
    func connect(host: String, port: Int) {
        Stream.getStreamsToHost(withName: host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        inputStream.delegate = self
        outputStream.delegate = self
        inputStream.schedule(in: .current, forMode: .default)
        outputStream.schedule(in: .current, forMode: .default)
        inputStream.open()
        outputStream.open()
    }
    
    func disconnect() {
        inputStream.close()
        outputStream.close()
        inputStream.remove(from: .current, forMode: .default)
        outputStream.remove(from: .current, forMode: .default)
    }
    
    private func receiveData() {
        while inputStream.hasBytesAvailable {
            let bufferSize = 1024
            var buffer = [UInt8](repeating: 0, count: bufferSize)
            let bytesRead = inputStream.read(&buffer, maxLength: bufferSize)
            if bytesRead > 0 {
                receiveBuffer.append(&buffer, count: bytesRead)
                
                while let packetRange = receiveBuffer.range(of: Data([0x25, 0xEB])) {
                    let packet = receiveBuffer.prefix(upTo: packetRange.lowerBound)
                    receiveBuffer.removeSubrange(..<packetRange.upperBound)
                    
                    if !packet.isEmpty {
                        DispatchQueue.main.async { [weak self] in
                            var finalPacket = Data([0x25, 0xEB])
                            finalPacket.append(packet)
                            self?.receivedPacket = finalPacket
                        }
                    }
                }
            }
        }
    }
}

extension TCPClient: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            receiveData()
        default:
            break
        }
    }
}
