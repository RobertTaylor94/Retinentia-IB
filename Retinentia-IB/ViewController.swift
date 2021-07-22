//
//  ViewController.swift
//  Retinentia-IB
//
//  Created by Robert Taylor on 03/07/2021.
//

import UIKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreNumberLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
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
    var highScore = 0
    let impact = UIImpactFeedbackGenerator()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
        scoreNumberLabel.text = "\(score)"
        let defaults = UserDefaults.standard
        let highScoreText = defaults.integer(forKey: "HighScore")
        highScoreLabel.text = "\(highScoreText)"
        highScore = highScoreText
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        enableButtons()
        updateSequence()
        print(sequence)
        startButton.isEnabled = false
//        animateButtons()
        start()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            sender.pulsate()
            buttonPressed(buttonNum: 1)
        case 2:
            sender.pulsate()
            buttonPressed(buttonNum: 2)
        case 3:
            sender.pulsate()
            buttonPressed(buttonNum: 3)
        case 4:
            sender.pulsate()
            buttonPressed(buttonNum: 4)
        case 5:
            sender.pulsate()
            buttonPressed(buttonNum: 5)
        case 6:
            sender.pulsate()
            buttonPressed(buttonNum: 6)
        case 7:
            sender.pulsate()
            buttonPressed(buttonNum: 7)
        case 8:
            sender.pulsate()
            buttonPressed(buttonNum: 8)
        case 9:
            sender.pulsate()
            buttonPressed(buttonNum: 9)
        default:
            print("error")
        }
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
                start()
            } else if userSequence != sequence {
                disableButtons()
                startButton.isEnabled = true
                print("Game Over")
                let alert = UIAlertController(title: "Game Over", message: "Score: \(score)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
                if score > highScore {
                    let defaults = UserDefaults.standard
                    defaults.set(score, forKey: "HighScore")
                    highScoreLabel.text = "\(score)"
                }
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

// MARK: - Animation Sequence

extension ViewController {
    func start() {
        disableButtons()
        let btnseq = buttonSequence
        self.animate(btnseq)
    }
    func animate(_ seq:[UIButton]) {
            if let b = seq.first {
                UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                    b.backgroundColor = UIColor(red: 63/255, green: 255/255, blue: 0/255, alpha: 1.0)
                }) { _ in
                    b.backgroundColor = UIColor(red: 168/255, green: 61/255, blue: 164/255, alpha: 0.85)
                    delay(0.1) {
                        self.animate(Array(seq.dropFirst()))
                    }
                }
            } else {
                enableButtons()
            }
        }
}

// MARK: - UIButton Extension

extension UIButton {
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.3
    pulse.fromValue = 0.98
    pulse.toValue = 1.0
    pulse.repeatCount = 1
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    layer.add(pulse, forKey: nil)
    }

}
