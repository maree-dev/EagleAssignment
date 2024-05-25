//
//  MockData.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

struct MockData {
  
  static let days: [Days] = [
    Days(personalExcuse: 0,
         absenceDueToBusiness: 0,
         paidTimeOff: 0,
         sickDays: 0,
         workFromHome: 0,
         patronSaintDay: 0)
  ]
  
  static let organization: [User] = [
    User(id: 11,
         email: "admin@test.net",
         firstName: "Admin",
         lastName: "Test",
         address: "Dr. Dragise Misovica 163, Cacak 32000, Serbia",
         phone: "0600155555",
         degree: "Masinski"),
    User(id: 81,
         email: "somebodies@delsystems.net",
         firstName: "Aleksandar",
         lastName: "Baković",
         address: "Svetog Save 85",
         phone: "",
         degree: "jeff"),
    User(id: 240,
         email: "sanja@gmail.com",
         firstName: "sanja",
         lastName: "mihailovic",
         address: "Stevana Sindjelica 5",
         phone: "064123456",
         degree: "Harward"),
    User(id: 397,
         email: "andrija@test.net",
         firstName: "Andrija",
         lastName: "Petrovic",
         address: "20ntain View, CA 94043, USA",
         phone: "06244598734",
         degree: "ftn cacak"),
    User(id: 490,
         email: "jovana@test.net",
         firstName: "Jovana",
         lastName: "Bradic",
         address: "Vojvode Stepe 2",
         phone: "0614444444",
         degree: "ICT"),
    User(id: 584,
         email: "korisnik@test.net",
         firstName: "Novi",
         lastName: "Korisnik",
         address: "",
         phone: "",
         degree: ""),
    User(id: 585,
         email: "test@test.net",
         firstName: "Test",
         lastName: "Test",
         address: "",
         phone: "",
         degree: ""),
    User(id: 586,
         email: "kandidat@test.net",
         firstName: "Kandidat",
         lastName: "Broj1",
         address: "",
         phone: "",
         degree: "")
  ]
}
