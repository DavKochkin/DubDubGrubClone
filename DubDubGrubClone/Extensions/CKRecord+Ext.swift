//
//  CKRecord+Ext.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 08.01.2024.
//

import CloudKit

extension CKRecord {
    
    func converToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func converToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
