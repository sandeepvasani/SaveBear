// Import the interfaces
#import "GameOverLayer.h"
#import "GameOverScene.h"

@implementation GameOverScene

-(id) init
{
	self = [super init];
    if (self != nil) {
	GameOverLayer *gameoverLayer = [GameOverLayer node];
        [self addChild:gameoverLayer z:5];
	
	}
	return self;

}

@end