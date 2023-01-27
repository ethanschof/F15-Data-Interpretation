//
//  fileInput.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/23/23.
//

import Foundation

class FileInput {
    
    var filename: String = ""
    var fd: Int32 = 0
    var byteArray: [UInt8] = []
    
    func FileInput(name: String) {
        self.filename = name
        self.fd = open(self.filename, O_RDONLY)
        
        if fd < 0 {
            perror("could not open \(self.filename)")
            parseBytes()
            print("Data Read-In Complete")
            close(fd)
        }
    }
    
    func parseBytes() {
        
    }
}
