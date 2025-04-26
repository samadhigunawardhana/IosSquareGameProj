//
//  LandingViewController.swift
//  SquareGame
//
//  Created by Samadhi Gunawardhana on 2025-02-01.
//

import UIKit

class LandingViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Square Color Match"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var easyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Easy Mode (2 min)", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(easyModeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mediumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Medium Mode (1 min)", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(mediumModeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var hardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hard Mode (30 sec)", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hardModeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var highScoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("High Scores", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showHighScores), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        title = "Square Color Match"
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(easyButton)
        view.addSubview(mediumButton)
        view.addSubview(hardButton)
        view.addSubview(highScoreButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            easyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            easyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            easyButton.widthAnchor.constraint(equalToConstant: 200),
            easyButton.heightAnchor.constraint(equalToConstant: 44),
            
            mediumButton.topAnchor.constraint(equalTo: easyButton.bottomAnchor, constant: 20),
            mediumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mediumButton.widthAnchor.constraint(equalToConstant: 200),
            mediumButton.heightAnchor.constraint(equalToConstant: 44),
            
            hardButton.topAnchor.constraint(equalTo: mediumButton.bottomAnchor, constant: 20),
            hardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hardButton.widthAnchor.constraint(equalToConstant: 200),
            hardButton.heightAnchor.constraint(equalToConstant: 44),
            
            highScoreButton.topAnchor.constraint(equalTo: hardButton.bottomAnchor, constant: 40),
            highScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            highScoreButton.widthAnchor.constraint(equalToConstant: 200),
            highScoreButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func easyModeTapped() {
        startGame(mode: .easy)
    }
    
    @objc private func mediumModeTapped() {
        startGame(mode: .medium)
    }
    
    @objc private func hardModeTapped() {
        startGame(mode: .hard)
    }
    
    private func startGame(mode: GameMode) {
        let gameVC = GameViewController(gameMode: mode)
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc private func showHighScores() {
        let alert = UIAlertController(title: "High Scores", message: getHighScoresMessage(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func getHighScoresMessage() -> String {
        let defaults = UserDefaults.standard
        let easyScore = defaults.integer(forKey: "HighScore_Easy")
        let mediumScore = defaults.integer(forKey: "HighScore_Medium")
        let hardScore = defaults.integer(forKey: "HighScore_Hard")
        
        return """
        Easy Mode: \(easyScore)
        Medium Mode: \(mediumScore)
        Hard Mode: \(hardScore)
        """
    }
}

