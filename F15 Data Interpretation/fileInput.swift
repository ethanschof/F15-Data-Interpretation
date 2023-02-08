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
    
    func parseBytes() {
        
    }
}
