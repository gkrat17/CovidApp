//
//  NSManagedObjectContextUtils.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import CoreData

extension NSManagedObjectContext {

    func fetchEntities<T : NSManagedObject> (
        withType type: T.Type,
        predicate: NSPredicate? = nil,
        completion: (Result<[T], Error>) -> Void
    ) {

        let request = NSFetchRequest<T>(entityName: T.description())
        request.predicate = predicate

        let result: [T]
        do { result = try fetch(request) }
        catch let error {
            completion(.failure(error))
            return
        }

        completion(.success(result))
    }
}
