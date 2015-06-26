//
//  Treasure.swift
//  TreasureHunt
//
//  Created by Dean Woodward on 26/11/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import MapKit

// MARK: Protocol - Alertable

@objc protocol Alertable {
  func alert() -> UIAlertController
}

// MARK: Treasure

class Treasure: NSObject {
  let what: String
  let location: GeoLocation
  
  init(what: String, location: GeoLocation) {
    self.what = what
    self.location = location
  }
  
  convenience init(what: String, latitude: Double, longitude: Double) {
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    self.init(what: what, location: location)
  }
  
  func pinColor() -> MKPinAnnotationColor {
    return MKPinAnnotationColor.Red
  }
}

extension Treasure: MKAnnotation {
  var coordinate: CLLocationCoordinate2D {
    return self.location.coordinate
  }
  
  var title: String {
    return self.what
  }
}

// MARK: HistoryTreasure

final class HistoryTreasure: Treasure {
  let year: Int
  
  init(what: String, year: Int, latitude: Double, longitude: Double) {
    self.year = year
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: what, location: location)
  }
  
  override func pinColor() -> MKPinAnnotationColor {
    return MKPinAnnotationColor.Purple
  }
}

extension HistoryTreasure: Alertable {
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "History", message: "\(self.year):\n\(self.what)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }
}

// MARK: FactTreasure

final class FactTreasure: Treasure {
  let fact: String
  
  init(what: String, fact: String, latitude: Double, longitude: Double) {
    self.fact = fact
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: what, location: location)
  }
}

extension FactTreasure: Alertable {
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "Fact", message: "\(self.what):\n\(self.fact)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }
}

// MARK: HQTreasure

final class HQTreasure: Treasure {
  let company: String
  
  init(company: String, latitude: Double, longitude: Double) {
    self.company = company
    let location = GeoLocation(latitude: latitude, longitude: longitude)
    super.init(what: company + " headquarters", location: location)
  }
  
  override func pinColor() -> MKPinAnnotationColor {
    return MKPinAnnotationColor.Green
  }
}

extension HQTreasure: Alertable {
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "HeadQuarters", message: "The headquarters of \(self.company)", preferredStyle: UIAlertControllerStyle.Alert)
    return alert
  }
}
