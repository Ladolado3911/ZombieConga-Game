//
//  GameScene.swift
//  ZombieConga
//
//  Created by Ladolado3911 on 06.11.21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        return background
    }()
    
    lazy var zombie: SKSpriteNode = {
        let zombie = SKSpriteNode(imageNamed: "zombie1")
        zombie.position = CGPoint(x: 400, y: 400)
        return zombie
    }()
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    let zombieMovePointsPerSecond: CGFloat = 480
    var velocity = CGPoint.zero
    
    override func didMove(to view: SKView) {
        // add background
        backgroundColor = SKColor.black
        addChild(background)
        
        // add zombie
        addChild(zombie)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }
        else {
            dt = 0
        }
        lastUpdateTime = currentTime
        //print(currentTime)
        //print("\(dt * 1000) milliseconds since last update")
        move(sprite: zombie,
             velocity: velocity)
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt),
                                   y: velocity.y * CGFloat(dt))
        
        //print("Amount to move \(amountToMove)")
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x,
                                  y: sprite.position.y + amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - zombie.position.x,
                             y: location.y - zombie.position.y)
        
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / length,
                                y: offset.y / length)
        
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSecond,
                           y: direction.y * zombieMovePointsPerSecond)
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        print("touch1")
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        print("touch2")
        sceneTouched(touchLocation: touchLocation)
    }
}

