//
//  ViewController.swift
//  SquareGame
//
//  Created by Samadhi Gunawardhana on 2025-02-01.
//

// ViewController.swift
import UIKit

class GameViewController: UIViewController {
    private var score = 0
    private var firstSelectedButton: UIButton?
    private var gameButtons: [UIButton] = []
    private var isGameStarted = false
    private var lastMatchedColor: UIColor?
    private let gameMode: GameMode
    private var timer: Timer?
    private var timeRemaining: TimeInterval
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Welcome to Square Match!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Score: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    init(gameMode: GameMode) {
        self.gameMode = gameMode
        self.timeRemaining = gameMode.timeLimit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = gameMode.description
        setupNavigationBar()
        setupUI()
        setupConstraints()
        updateTimerLabel()
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        let exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitGame))
        navigationItem.leftBarButtonItem = exitButton
    }
    
    private func setupUI() {
        // Create 9 game buttons
        for _ in 0..<9 {
            let button = UIButton()
            button.backgroundColor = .gray
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
            gameButtons.append(button)
            view.addSubview(button)
        }
        
        view.addSubview(statusLabel)
        view.addSubview(scoreLabel)
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(restartButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scoreLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let buttonSize: CGFloat = (view.frame.width - 80) / 3
        for (index, button) in gameButtons.enumerated() {
            let row = index / 3
            let col = index % 3
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20 + CGFloat(col) * (buttonSize + 20)),
                button.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40 + CGFloat(row) * (buttonSize + 20))
            ])
        }
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 44),
            
            restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.widthAnchor.constraint(equalToConstant: 200),
            restartButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func startButtonTapped() {
        isGameStarted = true
        score = 0
        scoreLabel.text = "Score: 0"
        startButton.isHidden = true
        restartButton.isHidden = false
        statusLabel.text = "Find matching colors!"
        lastMatchedColor = nil
        timeRemaining = gameMode.timeLimit
        startTimer()
        shuffleColors()
    }
    
    @objc private func restartButtonTapped() {
        startButtonTapped()
    }
    
    @objc private func exitGame() {
        timer?.invalidate()
        navigationController?.popViewController(animated: true)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    private func updateTime() {
        timeRemaining -= 1
        updateTimerLabel()
        
        if timeRemaining <= 0 {
            timer?.invalidate()
            timeOut()
        }
    }
    
    private func updateTimerLabel() {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        timerLabel.text = String(format: "Time: %02d:%02d", minutes, seconds)
    }
    
    private func timeOut() {
        let alert = UIAlertController(title: "Time's Up!", message: "You ran out of time!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
            self?.restartButtonTapped()
        })
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel) { [weak self] _ in
            self?.exitGame()
        })
        present(alert, animated: true)
    }
    
    @objc private func gameButtonTapped(_ sender: UIButton) {
        guard isGameStarted else { return }
        
        if let firstButton = firstSelectedButton {
            if firstButton == sender {
                return // Same button tapped twice
            }
            
            if firstButton.backgroundColor == sender.backgroundColor {
                // Ensure the matched color is different from the last match
                if let lastColor = lastMatchedColor, lastColor == sender.backgroundColor {
                    gameLost()
                    return
                }
                
                // Matching colors
                score += 5
                scoreLabel.text = "Score: \(score)"
                lastMatchedColor = sender.backgroundColor
                
                if score >= 25 {
                    gameWon()
                } else {
                    shuffleColors()
                }
            } else {
                // Non-matching colors - game over
                gameLost()
            }
            
            firstSelectedButton = nil
        } else {
            firstSelectedButton = sender
        }
    }
    
    private func shuffleColors() {
        let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .orange, .brown]
        var availableColors = colors.filter { $0 != lastMatchedColor }
        
        let matchingColorIndex = Int.random(in: 0..<availableColors.count)
        let matchingColor = availableColors.remove(at: matchingColorIndex)
        
        let matchingButtons = gameButtons.shuffled().prefix(2)
        matchingButtons.forEach { $0.backgroundColor = matchingColor }
        
        let remainingButtons = gameButtons.filter { !matchingButtons.contains($0) }
        for button in remainingButtons {
            if let randomIndex = availableColors.indices.randomElement() {
                button.backgroundColor = availableColors[randomIndex]
                availableColors.remove(at: randomIndex)
            }
        }
    }
    
    private func updateHighScore() {
        let defaults = UserDefaults.standard
        let key = "HighScore_\(gameMode.description.split(separator: " ")[0])"
        let currentHighScore = defaults.integer(forKey: key)
        if score > currentHighScore {
            defaults.set(score, forKey: key)
        }
    }
    
    private func gameWon() {
        isGameStarted = false
        timer?.invalidate()
        statusLabel.text = "Congratulations! You Won! 🎉"
        restartButton.isHidden = false
        updateHighScore()
        
        let alert = UIAlertController(title: "Congratulations!",
                                    message: "You won! Score: \(score)",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func gameLost() {
        isGameStarted = false
        timer?.invalidate()
        statusLabel.text = "Game Over! Try Again!"
        restartButton.isHidden = false
        
        let alert = UIAlertController(title: "Game Over",
                                    message: "Try again!",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
