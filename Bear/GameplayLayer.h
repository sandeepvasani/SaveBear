//
//  GameplayLayer.h
//  Bear
//
//  Created by macuser2 on 3/18/14.
//  Copyright Sandeep 2014. All rights reserved.

#import "CCLayer.h"
#import "cocos2d.h"
#import "CCParallaxScrollNode.h"
#import "CCParallaxScrollOffset.h"

@interface GameplayLayer : CCLayer
{
    
	CCSprite *bear;
   NSMutableArray * _traps;
	NSMutableArray *walkAnimFrames;
	CGSize size;
	
CCParallaxNode *backgroundNode;

    CCParallaxScrollNode * parallax;

  //  CCAction *birdleftmoveAction;
  //  CCAction *birdrightmoveAction;
 
}
//@property (nonatomic, strong) CCAction *birdmoveAction;

@end
