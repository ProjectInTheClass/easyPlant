//
//  Diary.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation

var diarys : [Diary] = [Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "ParlourPalm.jpeg"),
                        Diary(title: "초록콩 데려온 날1",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Moonshine.jpeg"),
                        Diary(title: "초록콩 데려온 날2",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Monstrous.jpeg"),
                        Diary(title: "초록콩 데려온 날3",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Violet.jpeg"),
                        Diary(title: "초록콩 데려온 날4",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Hoya.jpeg"),
                        Diary(title: "초록콩 데려온 날5",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Syngonium.jpeg"),
                        Diary(title: "초록콩 데려온 날6",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "DwarfUmbrellaTree.jpeg"),
                        Diary(title: "초록콩 데려온 날7",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Treean.jpeg"),
                        Diary(title: "초록콩 데려온 날8",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Eucalyptus.jpeg")]

struct Diary : Codable {
    var title : String
    var date : String
    var story : String
    var picture : String
}
