//
//  ViewController.swift
//  Project3
//
//  Created by Parhum Ebrahimian on 4/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovesLeft.text = "\(tMoves)"
        WorL.isHidden = true
    }
    
 
    var tMoves = 100
    var MemoryBrain: MemoryGameBrain = MemoryGameBrain()
    var stop = false
    var goBack: UIButton = UIButton()
    var once: UIButton = UIButton()
    var twice: UIButton = UIButton()
    var total = 0
    var Used: [UIButton] = [UIButton]()
    var PR = 100
    
    
    @IBOutlet weak var MovesLeft: UILabel!
    @IBOutlet weak var MovesMade: UILabel!
    @IBOutlet weak var WorL: UILabel!
    @IBAction func Reset(_ sender: UIButton) {
        Completion(sender)
    }
    @IBAction func Buttons(_ sender: UIButton) {

        var picture: UIImage

        let buttonTag = sender.tag

        if  goBack != sender && !MemoryBrain.Original(tag1: buttonTag) && !stop {

            goBack = sender

            if let movesleftLabel = MovesLeft.text, let movesString = MovesMade.text{

                let movesLeft = Int(movesleftLabel)! - 1

                MovesLeft.text = String(movesLeft)

                var movesMade = Int(movesString)!

                movesMade = movesMade + 1

                MovesMade.text = String(movesMade)

                let emoji =  MemoryBrain.getEmoji(tag: buttonTag)

                picture = UIImage()

                sender.setTitle(emoji, for: UIControl.State.normal)

                sender.setBackgroundImage(picture, for: UIControl.State.normal)

                Used.append(sender)

                if(total > 17){

                    total += 1

                }

                if(total == 19){

                    _ = MemoryBrain.isMatch(tag1: sender.tag, tag2: once.tag)

                }

                if movesMade % 2 == 1  {

                    if movesMade != 1{

                        let result = MemoryBrain.isMatch(tag1: once.tag, tag2: twice.tag)

                        if !result {

                            picture = (UIImage(named: "DOGE") as UIImage?)!

                            once.setBackgroundImage(picture, for: UIControl.State.normal)

                            once.setTitle("", for: UIControl.State.normal)

                            twice.setBackgroundImage(picture, for: UIControl.State.normal)

                            twice.setTitle("", for: UIControl.State.normal)

                            Used.remove(at: Used.count-2)

                            Used.remove(at: Used.count-2)

                        }else {

                            total = total + 2

                        }

                    }

                    once = sender

                }else {

                    twice = sender

                }

                if MemoryBrain.Winner() {

                    WorL.text = "WIN"

                    WorL.isHidden = false

                    stop = true

                    if(PR > movesMade){

                        PR = movesMade
                    }
                }else if movesLeft == 0 {

                    WorL.text = "end"

                    WorL.isHidden = false

                    stop = true
                
                }
            }
        }
    }
    

    func Completion(_ sender: UIButton){

        for aButton in Used {

            let picture: UIImage = (UIImage(named: "DOGE") as UIImage?)!

            aButton.setBackgroundImage(picture, for: UIControl.State.normal)

            aButton.setTitle("", for: UIControl.State.normal)
        }

        MemoryBrain = MemoryGameBrain.init()

        once = UIButton()
        goBack = UIButton()
        stop = false
        twice = UIButton()
        total = 0
        Used = [UIButton]()
        MovesMade.text = "0"
        WorL.isHidden = true

        let Difficulty = UIAlertController(title: "Please select a difficulty", message: "Personal Record: " + "\(PR)", preferredStyle: .actionSheet)

        
        
        func Rookie(_ act: UIAlertAction) {

            MovesLeft.text = "100"

            tMoves = 100

        }

        func AllStar(_ act: UIAlertAction) {

            MovesLeft.text = "75"

            tMoves = 75

        }

        func SuperStar(_ act: UIAlertAction) {

            MovesLeft.text = "50"

            tMoves = 50

        }

        func HOF(_ act: UIAlertAction) {

            MovesLeft.text = "25"

            tMoves = 25

        }

        func cancelHandler(_ act: UIAlertAction) {
        
            MovesLeft.text = "\(tMoves)"
        
        }
        
        Difficulty.addAction(UIAlertAction(title:"Rookie", style: .default, handler: Rookie))
        Difficulty.addAction(UIAlertAction(title:"All-Star", style: .default, handler: AllStar))
        Difficulty.addAction(UIAlertAction(title:"Super Star", style: .default, handler: SuperStar))
        Difficulty.addAction(UIAlertAction(title:"Hall of Fame", style: .default, handler: HOF))
        Difficulty.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: cancelHandler))
        
        
        
        self.present(Difficulty, animated: true)
        if let z = Difficulty.popoverPresentationController {
            let v = sender as UIView
            z.sourceView = view
            z.sourceRect = v.bounds
        }
    }
}
