//
//  RepositoryProtocol.swift
//  Comiditas
//
//  Created by Pedro Sousa on 14/09/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Data
    associatedtype Entity

    var coreDataStack: CoreDataStack { get set }
    var storageType: StorageType { get set }

    init(type: StorageType)

    func create(with data: Data) -> Entity?
    func readAll() -> [Entity]
    func read(identifier: UUID) -> Entity?
    func update(_ entity: Entity, with data: Data) -> Bool
    func delete(identifier: UUID) -> Bool
    func save() -> Bool
}
