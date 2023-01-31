//
//  fileInput.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/23/23.
//

import Foundation

class FileInput {
    
    var filename: String = "myChap10.ch10"
    var byteString: String = ""
    
    func FileInput(name: String) {
        self.filename = name
        do {
            // get the documents folder url
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent(self.filename)

                // reading from c10 file
                let savedText = try String(contentsOf: fileURL, encoding: .ascii)
                
                print("savedText:", savedText)   // Should be nonsense
                
                byteString = try String(contentsOf: fileURL, encoding: .ascii)
            }
        } catch {
            print("error:", error)
        }
        
    }
    
    func parseBytes() {
        
    }
}
