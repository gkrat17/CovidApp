//
//  CovidStatGateway.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

protocol CovidStatGateway: CovidStatFetchingGateway, CovidStatPersistingGateway { }
