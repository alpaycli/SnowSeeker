//
//  FileManager.swift
//  SnowSeeker
//
//  Created by Alpay Calalli on 02.12.22.
//

import Foundation

extension FileManager{
    static var documentsDirectory: URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
