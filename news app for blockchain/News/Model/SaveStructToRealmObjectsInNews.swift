////
////  SaveStructToRealmObjects.swift
////  news app for blockchain
////
////  Created by Rock on 14/5/18.
////  Copyright © 2018 Sheng Li. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//public final class WriteTransactionNews {
//    private let realm: Realm
//    internal init(realm: Realm) {
//        self.realm = realm
//    }
//    public func add<T: Persistable>(_ value: T, update: Bool) {
//        realm.add(value.managedObject(), update: update)
//    }
//}
//// Implement the Container
//public final class ContainerNews {
//    private let realm: Realm
//    public convenience init() throws {
//        try self.init(realm: Realm())
//    }
//    internal init(realm: Realm) {
//        self.realm = realm
//    }
//    public func write(_ block: (WriteTransactionNews) throws -> Void)
//        throws {
//            let transaction = WriteTransactionNews(realm: realm)
//            try realm.write {
//                try block(transaction)
//            }
//    }
//    
//}
//
//public protocol PersistableNews {
//    associatedtype ManagedObject: RealmSwift.Object
//    init(managedObject: ManagedObject)
//    func managedObject() -> ManagedObject
//}
