//
//  Toast.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/10/2024.
//

import Foundation



struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
