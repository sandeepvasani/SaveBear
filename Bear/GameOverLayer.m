//  SpaceShip
//
//  Created by macuser2 on 3/18/14.
//  Copyright Sandeep 2014. All rights reserved.

// Import the interfaces
#import "GameOverLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@implementation GameOverLayer

-(id) init
{
	self = [super init];
    if (self != nil) {
		CCLabelTTF *label =[CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Marker Felt" fontSize:65];
		CGSize size=[[CCDirector sharedDirector]winSize];

		label.position=ccp(size.width/2,size.height/2);
		[self addChild: label];
	}
	return self;

}

@end