//
//  RepositoryProtocol.swift
//  Comiditas
//
//  Created by Pedro Sousa on 14/09/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype D
    associatedtype E

    var coreDataStack: CoreDataStack { get set }
    var storageType: StorageType { get set }

    init(type: StorageType)

    func create(with data: D) -> E?
    func readAll() -> [E]
    func read(identifier: UUID) -> E?
    func update(_ entity: E, with data: D) -> Bool
    func delete(identifier: UUID) -> Bool
    func save() -> Bool
}
