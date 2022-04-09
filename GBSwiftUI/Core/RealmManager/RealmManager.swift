//
//  RealmManager.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 01.04.2022.
//

import RealmSwift

protocol RealmManagerProtocolInput {
    func add<T: Object>(object: T) throws
    func add<T: Object>(object: [T], update: Realm.UpdatePolicy) throws
    func update<T: Object>(type: T, primaryKeyValue: Any, setNewValue: Any, field: String) throws
    func getObjects<T: Object>(type: T.Type) -> Results<T>
    func delete<T: Object>(object: T) throws
    func deleteAll() throws
}

final class RealmManager: RealmManagerProtocolInput {
    
    private let realm: Realm

    init?() {
        let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: configuration) else { return nil }
        print(realm.configuration.fileURL ?? "")
        self.realm = realm
    }

    func add<T: Object>(object: T) throws {
        try realm.write {
            realm.add(object, update: .modified)
        }
    }

    func add<T: Object>(
        object: [T],
        update: Realm.UpdatePolicy = .modified
    ) throws {
        try realm.write {
            realm.add(object, update: .modified)
        }
    }

    func update<T: Object>(
        type: T,
        primaryKeyValue: Any,
        setNewValue: Any,
        field: String
    ) throws {
        try realm.write {
            guard let primaryKey = T.primaryKey() else {
                print("No primaryKey for object \(T.self)")
                return
            }
            let target = realm.objects(T.self).filter("\(primaryKey) = %@", primaryKeyValue)
            target.setValue(setNewValue, forKey: "\(field)")
        }
    }

    func getObjects<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }

    func delete<T: Object>(object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }

    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
}

protocol DetachableObject: AnyObject {
    func detached() -> Self
}

extension Object: DetachableObject {
    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else {
                continue
            }
            if let detachable = value as? DetachableObject {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}
