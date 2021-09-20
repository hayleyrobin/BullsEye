//
//  ViewController.swift
//  BullsEye
//
//  Created by Hayley Robinson on 9/13/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    
    override func viewDidLoad() // only called once during app startup
    {
        super.viewDidLoad()
        startNewGame()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }


    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference

        let title: String
        if difference == 0 {
          title = "Perfect!"
            points += 100
        } else if difference < 5 {
          title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }
        score += points // adds the points that the user scored in this round to the total score.
        
        let message = "You scored \(points) points!"
            /*"The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" //shows random number + "\nThe difference is: \(difference)"
            */
        
        // Pop up alert
        let alert = UIAlertController(
        title: title, // big title of alert pops up
        message: message,
        preferredStyle: .alert)

        let action = UIAlertAction(
        title: "OK",          
        style: .default,
        handler: {_ in
            self.startNewRound()
        })  // instead of nil, startnewround() when OK is tapped

        alert.addAction(action)

        present(alert, animated: true, completion: nil) // puts the alert on the screen and immediately returns control to the next line of code in the method. T
        
        

    }
   
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
     
    }
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100) //makes random number
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    @IBAction func startNewGame() //action when click start over button
    {
      score = 0 //reset score and round to 0 & start new round
      round = 0
      startNewRound()
    }
    func updateLabels() {
      targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }



}

