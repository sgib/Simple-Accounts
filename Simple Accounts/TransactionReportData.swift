//
//  TransactionReportData.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

struct TransactionReportData {
    let range: CustomTransactionDateRange
    let transactions: [TransactionCollection]
}