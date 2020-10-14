//
//  LocalPersistenceCovidStatGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import CoreData

protocol LocalPersistenceCovidStatGateway: CovidStatGateway { }

struct LocalPersistenceCovidStatGatewayImplementation: LocalPersistenceCovidStatGateway {

    let service: PersistenceService

    // MARK: - CovidStatFetchingGateway Part

    func fetchSummaries(_ completion: @escaping FetchSummariesHandler) {
        service.context.fetchEntities(withType: DBCovidSummaryEntity.self) { (result) in
            switch result {
            case .success(let summaries):
                completion(.success(summaries.map { $0.toCovidSummaryEntity() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchDetails(for identifier: CountryIdentifier,
                      _ completion: @escaping FetchDetailsHandler) {

        requireDetails(for: identifier) { (result) in
            switch result {
            case .success(let details):

                if let details = details.toCovidDetailsEntity() {
                    completion(.success(details))
                } else {
                    completion(.failure(CoreError(message: "Some casting error occured while fetching details")))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchNotificationsState(for identifier: CountryIdentifier,
                                 _ completion: FetchNotificationsStateHandler) {

        requireDetails(for: identifier) { (result) in
            switch result {
            case .success(let details):
                completion(.success(details.notifications))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - CovidStatPersistingGateway Part

    func upsertSummaries(_ summaries: [CovidSummaryEntity],
                         _ completion: UpsertSummariesHandler?) {

        let context = service.context

        var error: Error? = nil // last error

        for summary in summaries {

            findSummary(for: summary.identifier) { (result) in
                switch result {
                case .success(let dbSummary):

                    var dbSummary = dbSummary ?? DBCovidSummaryEntity(context: context)
                    summary.fill(dbCovidSummary: &dbSummary)

                case .failure(let err):
                    error = err
                }
            }
        }

        service.saveContext() // error?

        if let error = error {
            completion?(.failure(error))
        } else {
            completion?(.success(()))
        }
    }

    func upsertDetails(_ details: CovidDetailsEntity,
                       _ completion: UpsertDetailsHandler?) {

        findSummary(for: details.identifier) { (result) in
            switch result {
            case .success(let summary):

                if let summary = summary {
                    let context = service.context

                    var dbDetails = summary.details ?? { // get or create
                        let details = DBCovidDetailsEntity(context: context)
                        details.summary = summary
                        summary.details = details
                        return details
                    }()

                    details.fill(dbCovidDetails: &dbDetails, context: context)
                    service.saveContext() // error?
                    completion?(.success(()))

                } else {
                    completion?(.failure(CoreError(message: "There is no appropriate country for saving its details")))
                }

            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func updateNotificationsState(for identifier: CountryIdentifier,
                                  with state: NotificationsState,
                                  _ completion: UpdateNotificationHandler?) {

        requireDetails(for: identifier) { (result) in
            switch result {
            case .success(let details):
                details.notifications = state
                service.saveContext() // error?
                completion?(.success(()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    // MARK: - Helpers

    private func findSummary(for identifier: CountryIdentifier,
                             _ completion: (Result<DBCovidSummaryEntity?, Error>) -> Void) {

        service.context.fetchEntities(withType: DBCovidSummaryEntity.self,

            predicate: NSPredicate (
                format: "identifier == %@",
                identifier
            )

        ) { (result) in

            switch result {
            case .success(let summaries):
                assert(summaries.count < 2) // comment me later
                completion(.success(summaries.first))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func requireDetails(for identifier: CountryIdentifier,
                                _ completion: (Result<DBCovidDetailsEntity, Error>) -> Void) {

        service.context.fetchEntities(withType: DBCovidDetailsEntity.self,

            predicate: NSPredicate (
                format: "summary.identifier == %@",
                identifier
            )

        ) { (result) in

            switch result {
            case .success(let details):
                assert(details.count < 2) // comment me later
                if let details = details.first {
                    completion(.success(details))
                } else {
                    completion(.failure(CoreError(message: "Requested covid details not found")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Extension of CovidSummaryEntity for filling up DBCovidSummaryEntity

fileprivate extension CovidSummaryEntity {

    func fill(dbCovidSummary s: inout DBCovidSummaryEntity) {

        s.identifier = identifier
        s.countryName = countryName

        if let totalConfirmed = totalConfirmed {
            s.totalConfirmed = Int32(totalConfirmed)
        }

        if let totalDeaths = totalDeaths {
            s.totalDeaths = Int32(totalDeaths)
        }

        if let totalRecovered = totalRecovered {
            s.totalRecovered = Int32(totalRecovered)
        }
    }
}

// MARK: - Extension of CovidDetailsEntity for filling up DBCovidDetailsEntity

fileprivate extension CovidDetailsEntity {

    func fill(dbCovidDetails d: inout DBCovidDetailsEntity, context: NSManagedObjectContext) {

        // update notifications
        d.notifications = hasNotifications

        // update confirmed set
        let set = d.mutableSetValue(forKey: "confirmed")
        set.removeAllObjects()

        confirmed.forEach { entity in
            var dbEntity = DBConfirmedEntity(context: context)
            entity.fill(dbConfirmedEntity: &dbEntity)
            set.add(dbEntity)
        }
    }
}

// MARK: - Extension of ConfirmedEntity for filling up DBConfirmedEntity

fileprivate extension ConfirmedEntity {

    func fill(dbConfirmedEntity c: inout DBConfirmedEntity) {
        c.count = Int32(count)
        c.date = date
    }
}
