//  MemoryGameBrain.swift
//  Project3
//
//  Created by Parhum Ebrahimian on 4/27/21.
//

import Foundation

struct card {

    let emoji: String

    var matched: Bool
}






class MemoryGameBrain {

    var Field = [[card]]()

    init() {

        let fart = card(emoji: "testing", matched: false)

        let cards = [fart,fart,fart,fart]
//randomly fills the board
        Field.append(cards)
        Field.append(cards)
        Field.append(cards)
        Field.append(cards)
        Field.append(cards)
        var flag = ["🇺🇸", "🏳️‍🌈", "🇸🇦", "🇳🇨", "🇲🇲", "🇰🇷", "🇧🇷", "🇨🇩", "🇮🇳", "🏳","🇺🇸", "🏳️‍🌈", "🇸🇦", "🇳🇨", "🇲🇲",
                    "🇰🇷", "🇧🇷", "🇨🇩", "🇮🇳", "🏳"]

        for x in 0...19{

            let index = Int.random(in: 0 ... flag.count-1)


            Field[x/4][x%4] = card(emoji: flag[index], matched: false)

            flag.remove(at: index)
        }
    }
//defines a winner when the field is fully matched
    func Winner() -> Bool {

        for x in 0...19{

            if Field[x/4][x%4].matched == false {

                return false
            }
        }

        return true
    }

    func getEmoji(tag: Int) -> String {

        let emoji =  Field[tag/4][tag%4].emoji

        return emoji
    }
// the two cards are paired if their tags match each other
    func isMatch(tag1: Int, tag2: Int) -> Bool {

        if getEmoji(tag: tag1) == getEmoji(tag: tag2) {

            Field[tag1/4][tag1%4].matched = true

            Field[tag2/4][tag2%4].matched = true

            return true
        }

        return false
    }

    func Original(tag1: Int) -> Bool{

        let x = Field[tag1/4][tag1%4].matched

        return x
    }
}
