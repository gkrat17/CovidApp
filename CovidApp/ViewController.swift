//
//  ViewController.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/13/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gateway: CovidStatFetchingGateway = ApiCovidStatGatewayImplementation(service: ApiServiceImplemetation.defaultShared)

        gateway.fetchSummaries { (result) in
            switch result {
            case .success(let summaries):
                print("Success:", summaries)
                let summary = summaries[0]
                gateway.fetchDetails(for: summary.identifier) { (result) in
                    print("Call of fetchDetails:", result)
                }
            case .failure(let error):
                print("Error in fetchSummaries:", error)
            }
        }

        /*let gateway: CovidStatGateway = LocalPersistenceCovidStatGatewayImplementation (
            service: PersistenceServiceImplementation.shared
        )

        gateway.fetchSummaries { (result) in
            print("First Call of fetchSummaries:", result)
            let summaries: [CovidSummaryEntity] = [
                .init(identifier: "telavi", countryName: "Telavi", totalConfirmed: 6, totalDeaths: 6, totalRecovered: 6),
                .init(identifier: "gurjaani", countryName: "Gurjaani", totalConfirmed: 7, totalDeaths: 7, totalRecovered: 7)
            ]
            print("Tring to call upsertSummaries with summaries:", summaries)
            gateway.upsertSummaries(summaries) { (result) in
                print("First Call of upsertSummaries:", result)
                let details = CovidDetailsEntity(identifier: "telavi",
                                                 hasNotifications: true,
                                                 confirmed: [
                                                    .init(count: 7, date: Date()),
                                                    .init(count: 6, date: Date())
                                                 ])
                print("Tring to call upsertDetails with details:", details)
                gateway.upsertDetails(details) { (result) in
                    print("First Call of upsertDetails:", result)
                    gateway.fetchDetails(for: "telavi") { (result) in
                        print("First Call of fetchDetails:", result)
                    }
                }
            }
        }*/
    }
}
