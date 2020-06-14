//
//  Proffesions.swift
//  LuckyTeam_HW2.8
//
//  Created by mac on 14.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

enum Proffesion: String {
    case doctor = "Врач"
    case pilot = "Пилот"
    case teacher = "Учитель"
    case artist = "Артист"
    case civilServant = "Госслужащий"
    case police = "Полиция"
    case programer = "Програмист"
    case fotograf = "Фотограф"
    case lawyer = "Юрист"
    case sportman = "Спортсмен"
    case designer = "Дизайнер"
    case engineer = "Инженер"
    case mechanic = "Механик"
    case postman = "Почтальйон"
    case taxiDriver = "Водитель таксі"
    case translator = "Переводчик"
    case travelAgent = "Агент"

    static func getAllValues() -> [Proffesion]{
        return [.doctor,
                .pilot,
                .teacher,
                .artist,
                .civilServant,
                .police,
                .programer,
                .fotograf,
                .lawyer,
                .sportman,
                .designer,
                .engineer,
                .mechanic,
                .postman,
                .taxiDriver,
                .translator,
                .travelAgent]
    }
}
