//
//  CloudKitManager.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 08.01.2024.
//

import CloudKit

struct CloudKitManager {
    
    static func getLocations(completion: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            let locations = records.map { $0.converToDDGLocation() }
            
            completion(.success(locations))
        }
    }
}
