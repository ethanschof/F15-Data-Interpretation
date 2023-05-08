//
//  TCPSocket.swift
//  F15 Data Interpretation
//
//  Created by Colin M. Seymour on 3/20/23.
//  Pulled and retrofitted from code base by LtCol Wilson
//

import Foundation
import Network

class TCPClient: NSObject {
    var connection: NWConnection?
    var queue: DispatchQueue
    var hostString: String
    var portString: String
    
    init(ipAddress address: String, portNumber portNum: String) {
        queue = DispatchQueue(label: "TCP Client Queue")
        self.hostString = address
        self.portString = portNum
        
        let host = NWEndpoint.Host(address)
        let port = NWEndpoint.Port(portNum)!
        self.connection = NWConnection(host: host, port: port, using: .tcp)
        
        print(self.connection!.parameters.debugDescription)
        self.connection?.stateUpdateHandler = { (newState) in //[weak self] to pass self in as an optional
            switch(newState) {
            case .ready:
                print("[TCPClient] Ready to send...")
            case .failed(let error):
                print("[TCPClient] failed with error: \(error)")
            default:
                break
            }
        }
        
        self.connection?.start(queue: self.queue)
    }
    
    func sendData(_ payload: Data) {
        connection?.send(content: payload, completion: .contentProcessed { (error) in
            //print("[TCPClient] packet Sent")
            if let error = error {
                print("[TCPClient.sendData] send error: \(error)")
            }
            })
    }
    
    func sendData(_ payloads: [Data]) {
        connection?.batch {
            for payload in payloads {
                print(String(bytes: payload, encoding: .utf8)!)
                connection?.send(content: payload, completion: .contentProcessed { (error) in
                    //print("[TCPClient] packet Sent")
                    if let error = error {
                    print("[TCPClient.sendData] send error: \(error)")
                    }
                })
            }
        }
        
        //print payload sizes as {size, size, ...}
        var payloadSizes: String = "Packet sizes - {"
        for (i, payload) in payloads.enumerated() {
            payloadSizes += String(payload.count)
            if(i != payloads.count - 1) {
                payloadSizes += ","
            }
        }
        payloadSizes += "}"
        
        print("[TCPClient] Packets Sent: \(payloadSizes)")
 
        //per meeting L3's system will never respond
    }
    
    func setNewAddress(withAddress address: String, withPort port: String) {
        self.connection?.cancel()
        self.createConnection(withAddress: address, withPort: port)
    }
    
    func resetConnection() {
        createConnection(withAddress: self.hostString, withPort: self.portString)
    }
    
    private func createConnection(withAddress address: String, withPort portNum: String) {
        
        self.hostString = address
        self.portString = portNum
        let host = NWEndpoint.Host(address)
        let port = NWEndpoint.Port(portNum)!
        self.connection = NWConnection(host: host, port: port, using: .tcp)
        
        print(self.connection!.parameters.debugDescription)
        self.connection?.stateUpdateHandler = { (newState) in //[weak self] to pass self in as an optional
            switch(newState) {
            case .ready:
                print("[TCPClient] Ready to send...")
            case .failed(let error):
                print("[TCPClient] failed with error: \(error)")
            default:
                break
            }
        }
        
        self.connection?.start(queue: self.queue)
    }
}
