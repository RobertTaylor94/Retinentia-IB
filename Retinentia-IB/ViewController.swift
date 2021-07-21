//
//  ViewController.swift
//  Retinentia-IB
//
//  Created by Robert Taylor on 03/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreNumberLabel: UILabel!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var score = 0
    var userSequence: [Int] = []
    var sequence: [Int] = []
    var buttonSequence: [UIButton] = []
    var secondsToDelay = 2.0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
        scoreNumberLabel.text = "\(score)"
    }

    @IBAction func startPressed(_ sender: UIButton) {
        enableButtons()
        updateSequence()
        print(sequence)
        startButton.isEnabled = false
        animateButtons()
    }
    
    
    @IBAction func buttonOnePressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 1)
    }
    
    @IBAction func buttonTwoPressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 2)
    }
    
    @IBAction func buttonThreePressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 3)
    }
    
    @IBAction func buttonFourPressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 4)
    }
    
    @IBAction func buttonFivePressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 5)
    }
    
    @IBAction func buttonSixPressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 6)
    }
    
    @IBAction func buttonSevenPressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 7)
    }
    
    @IBAction func buttonEightPressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 8)
    }
    
    @IBAction func buttonNinePressed(_ sender: UIButton) {
        buttonPressed(buttonNum: 9)
    }
    

}

// MARK: - Button Group Function

extension ViewController {
    func disableButtons() {
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
        buttonFive.isEnabled = false
        buttonSix.isEnabled = false
        buttonSeven.isEnabled = false
        buttonEight.isEnabled = false
        buttonNine.isEnabled = false
    }
    
    func enableButtons() {
        buttonOne.isEnabled = true
        buttonTwo.isEnabled = true
        buttonThree.isEnabled = true
        buttonFour.isEnabled = true
        buttonFive.isEnabled = true
        buttonSix.isEnabled = true
        buttonSeven.isEnabled = true
        buttonEight.isEnabled = true
        buttonNine.isEnabled = true
    }
}

// MARK: - ButtonPressed

extension ViewController {
    func buttonPressed(buttonNum: Int) {
        
        userSequence.append(buttonNum)
        
        if userSequence.count < sequence.count {
            print(userSequence)
        } else if userSequence.count == sequence.count {
            if userSequence == sequence {
                score += 1
                scoreNumberLabel.text = "\(score)"
                updateSequence()
                userSequence = []
                print(sequence)
                animateButtons()
            } else if userSequence != sequence {
                disableButtons()
                startButton.isEnabled = true
                print("Game Over")
                highScore = score
                score = 0
                scoreNumberLabel.text = "\(score)"
                userSequence = []
                sequence = []
                buttonSequence = []
            }
        }
        
        
    
    }
    
    func updateSequence() {
        let buttonArray = [buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix, buttonSeven, buttonEight, buttonNine]
        let randomInt = Int.random(in: 1...9)
        sequence.append(randomInt)
        buttonSequence.append(buttonArray[sequence.last! - 1]!)
    }
}


// MARK: - Animation

extension ViewController {
    
    func animateButtons() {
        for (index, button) in buttonSequence.enumerated() {
            UIButton.animate(withDuration: 1, delay: TimeInterval(index)) {
                button.backgroundColor = UIColor(red: 63/255, green: 255/255, blue: 0/255, alpha: 1.0)
                button.backgroundColor = UIColor(red: 168/255, green: 61/255, blue: 164/255, alpha: 0.85)
            }
        }
    }
    
}
    
    
//        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
//            for button in self.buttonSequence {
//
//                button.backgroundColor = UIColor(red: 63/255, green: 255/255, blue: 0/255, alpha: 1.0)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    button.backgroundColor = UIColor(red: 168/255, green: 61/255, blue: 164/255, alpha: 0.85)
//                }
//            }
//        })
//    }

