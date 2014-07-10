//
//  GameplayLayer.m
//  SpaceShip
//
//  Created by macuser2 on 3/18/14.
//  Copyright Sandeep 2014. All rights reserved.

#import "GameplayLayer.h"
#import "GameOverScene.h"


@implementation GameplayLayer

-(id)init {
    self = [super init];
    if (self != nil) {
         CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCSprite *sky = [CCSprite spriteWithFile:@"Sky.png"];
        sky.position=ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:sky z:-10];
		
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BearWalk_default.plist"];
	CCSpriteBatchNode *walkingspriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"BearWalk_default.png"];
	[self addChild:walkingspriteSheet];
	
	_traps = [[NSMutableArray alloc] init];
	
	walkAnimFrames = [NSMutableArray array];
	for (int i=1; i<=8; i++) {
    [walkAnimFrames addObject:
        [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
            [NSString stringWithFormat:@"bear%d.png",i]]];
	}

	CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
	
	
bear = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
bear.position = ccp(screenSize.width*0.4, screenSize.height*0.1);
CCAction *walkAction = [CCRepeatForever actionWithAction:
    [CCAnimate actionWithAnimation:walkAnim]];
[bear runAction:walkAction];
[walkingspriteSheet addChild:bear];
id repeat =[CCRepeatForever actionWithAction: walkAction];
[bear runAction:repeat];
/*

	// 1) Create the CCParallaxNode
backgroundNode = [CCParallaxNode node];
[self addChild:backgroundNode z:-1];
 
// 2) Create the sprites we'll add to the CCParallaxNode
ground = [CCSprite spriteWithFile:@"Ground.png"];
sky = [CCSprite spriteWithFile:@"Sky.png"];
mountain = [CCSprite spriteWithFile:@"Mountain.png"];
trees = [CCSprite spriteWithFile:@"Trees.png"];
 
// 3) Determine relative movement speeds for space dust and background
CGPoint groundSpeed = ccp(1, 1);
CGPoint treesSpeed = ccp(0.05, 0.05);
CGPoint mountainSpeed = ccp(0.025, 0.025);
CGPoint skySpeed = ccp(0, 0);


 
// 4) Add children to CCParallaxNode
[_backgroundNode addChild:trees z:0 parallaxRatio:treesSpeed positionOffset:ccp(0,winSize.height/2)];
[_backgroundNode addChild:ground z:-1 parallaxRatio:groundSpeed positionOffset:ccp(_spacedust1.contentSize.width,winSize.height/2)];        
[_backgroundNode addChild:mountain z:-2 parallaxRatio:mountainSpeed positionOffset:ccp(0,winSize.height * 0.7)];
[_backgroundNode addChild:sky z:-3 parallaxRatio:skySpeed positionOffset:ccp(600,winSize.height * 0)];     

*/

        self.touchEnabled = YES;
        [self scheduleUpdate];


    parallax = [CCParallaxScrollNode node];
    
    // Create sprites from file
    CCSprite *mountain1 = [CCSprite spriteWithFile:@"Mountain.png"];
    CCSprite *mountain2 = [CCSprite spriteWithFile:@"Mountain.png"];
        
    CCSprite *trees1 = [CCSprite spriteWithFile:@"Trees.png"];
    CCSprite *trees2 = [CCSprite spriteWithFile:@"Trees.png"];
        
    CCSprite *ground1 = [CCSprite spriteWithFile:@"Ground.png"];
    CCSprite *ground2 = [CCSprite spriteWithFile:@"Ground.png"];
        


	
        [parallax addInfiniteScrollXWithZ:-9 Ratio:ccp(0.2,0.2) Pos:ccp(0,0) Objects:mountain1, mountain2, nil];
        [parallax addInfiniteScrollXWithZ:-7 Ratio:ccp(0.35,0.35) Pos:ccp(0,0) Objects:trees1, trees2, nil];
        [parallax addInfiniteScrollXWithZ:-8 Ratio:ccp(1,1) Pos:ccp(0,0) Objects:ground1, ground2, nil];
	[self addChild:parallax z:-1];

        [self schedule:@selector(gameLogic:) interval:3.0];

    }
    return self;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
    
    id jump_Up = [CCJumpBy actionWithDuration:1.5f position:ccp(0, 0)
                                    height:50 jumps:1];
    //id jump_Down = [CCJumpBy actionWithDuration:1.0f position:ccp(0,0)
                                   // height:50 jumps:0];

    id seq = [CCSequence actions:jump_Up, nil];

    [bear runAction:seq];
    
	
}

-(void)gameLogic:(ccTime)dt {
    [self addTrap];
}

- (void)addTrap{
 
    CCSprite *trap = [CCSprite spriteWithFile:@"BearTrap.png"];
 
    trap.position = CGPointMake(self.contentSize.width + trap.contentSize.width/2, 18.0f);
    [self addChild:trap];
 
 
    
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:4
      position:ccp(-trap.contentSize.width/2, 15.0f)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    [trap runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	trap.tag = 1;
	[_traps addObject:trap];
 
}

-(void)repscene
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScene node] ]];

}

-(void)update:(ccTime)delta
{
    

		float myVelocity = -4;
        [parallax updateWithVelocity:ccp(myVelocity, 0) AndDelta:delta];
    
  
	for (CCSprite *trap in _traps) {
        CGRect tempBoundingBox = CGRectInset([trap boundingBox], 14, 5);
        
        if (CGRectIntersectsRect(tempBoundingBox , bear.boundingBox)) {
					
          [self repscene];
            //NSLog(@"collision");
        }
    }
	    
      
    
}

-(void) dealloc{
    [_traps release];
    _traps = nil;
}

@end
