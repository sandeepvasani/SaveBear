//
//  GameScene.m
//  SpaceShip
//
//  Created by macuser2 on 3/18/14.
//  Copyright Sandeep 2014. All rights reserved.

#import "GameplayScene.h"

#import "GameplayLayer.h"


@implementation GameplayScene

-(id)init {
    self = [super init];
    if (self != nil) {
        
        
        // Gameplay Layer
        GameplayLayer *gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];

    }
    return self;
}

@end
