//
//  AgeToPension.swift
//  LuckyTeam_HW2.8
//
//  Created by mac on 14.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

struct AgeToPension {
    var maleAge: Int
    var femaleAge: Int

    static func getAge() -> AgeToPension {
        return AgeToPension(maleAge: 60, femaleAge: 55)
    }
}
