//
//  AddEditMode.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 03/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

enum AddEditMode<T> {
    case Add
    case Edit(T)
}

enum AddEditResult<T> {
    case DidAdd(T)
    case DidEdit(T)
    case DidDelete
}