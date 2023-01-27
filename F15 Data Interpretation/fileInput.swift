//
//  fileInput.swift
//  F15 Data Interpretation
//
//  Created by Capstone 2023 on 1/23/23.
//

import Foundation
import BinarySwift

class FileInput {
    let fileURL = Bundle.main.url(forResource: "myChap10", withExtension: "ch10")
    let fileContents = try? String(contentsOf: fileURL! ?? <#default value#>)
    
    
    
//    let data = BinaryData(data: nsData, bigEndian: default)
    //    let reader = BinaryDataReader(data)
    
}
