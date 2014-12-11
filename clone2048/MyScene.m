//
//  MyScene.m
//  clone2048
//
//  Created by Ilya Boltnev on 16/08/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
@synthesize board;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
        self.board = [[Board alloc] initWithSize:self.size.width
                                        WithScene:self];
        
        /* score windows */
        
        SKLabelNode* scorePlaceLabel = [[SKLabelNode alloc] init];
        scorePlaceLabel.name = @"scorePlaceCurrent";
        scorePlaceLabel.text = @"0";
        scorePlaceLabel.position = CGPointMake(self.size.width * 0.2, self.size.height * 0.035);
        
        self->scorePlace = [[SKShapeNode alloc] init];
        CGRect scoreShape = CGRectMake(0,0, self.size.width * 0.4, self.size.width * 0.2);
        [self->scorePlace setPath:CGPathCreateWithRoundedRect(scoreShape, 5, 5, nil)];
        self->scorePlace.position = CGPointMake(self.size.width * 0.05, self.size.height * 0.85 );
        self->scorePlace.strokeColor =  self->scorePlace.fillColor = [SKColor colorWithRed:255 / 255.0
                                                                                   green:207 / 255.0
                                                                                    blue:74 / 255.0
                                                                                   alpha:0.8];
        [scorePlace addChild:scorePlaceLabel];
        [self addChild:self->scorePlace];
        
        SKLabelNode* valuePlaceLabel = [[SKLabelNode alloc] init];
        valuePlaceLabel.name = @"valuePlaceCurrent";
        valuePlaceLabel.text = @"0";
        valuePlaceLabel.position = CGPointMake(self.size.width * 0.2, self.size.height * 0.035);
        
        self->valuePlace = [[SKShapeNode alloc] init];
        [self->valuePlace setPath:CGPathCreateWithRoundedRect(scoreShape, 5, 5, nil)];
        self->valuePlace.position = CGPointMake(self.size.width * 0.55, self.size.height * 0.85 );
        self->valuePlace.strokeColor =  self->valuePlace.fillColor = [SKColor colorWithRed:255 / 255.0
                                                                                     green:207 / 255.0
                                                                                      blue:74 / 255.0
                                                                                     alpha:0.8];
        [valuePlace addChild:valuePlaceLabel];
        [self addChild:self->valuePlace];
        /* restart button */
        SKShapeNode* restartButton = [[SKShapeNode alloc] init];
        [restartButton setPath:CGPathCreateWithRoundedRect(scoreShape, 5, 5, nil)];
        restartButton.position = CGPointMake(self.size.width * 0.05, self.size.height * 0.1 );
        restartButton.strokeColor =  restartButton.fillColor = [SKColor colorWithRed:255 / 255.0
                                                                                     green:207 / 255.0
                                                                                      blue:74 / 255.0
                                                                                     alpha:0.8];
        restartButton.name = @"restartButton";
        SKLabelNode* restartButtonLabel = [[SKLabelNode alloc] init];
        restartButtonLabel.text = @"RESTART";
        restartButtonLabel.name = restartButton.name;
        restartButtonLabel.position = CGPointMake(self.size.width * 0.2, self.size.height * 0.035);
        [restartButton addChild:restartButtonLabel];
        [self addChild: restartButton];
    }
    return self;
}

-(void) didMoveToView:(SKView *)view{
    swipeRightGesture = [[ UISwipeGestureRecognizer alloc ] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:swipeRightGesture];

    swipeLeftGesture = [[ UISwipeGestureRecognizer alloc ] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [view addGestureRecognizer:swipeLeftGesture];

    swipeUpGesture = [[ UISwipeGestureRecognizer alloc ] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeUpGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [view addGestureRecognizer:swipeUpGesture];

    swipeDownGesture = [[ UISwipeGestureRecognizer alloc ] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeDownGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [view addGestureRecognizer:swipeDownGesture];
}


-(void) handleSwipe:(UISwipeGestureRecognizer *) recognizer{
    enum GAMESTATE result;
    switch(recognizer.direction){
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"Right swipe");
            result = [self.board rightMove];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Left swipe");
            result = [self.board leftMove];
            break;
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"Up swipe");
            result = [self.board upMove];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"Down swipe");
            result = [self.board downMove];
            break;
        default:
            NSLog(@"Unknown swipe");
    }
    
    if(result == GAMEOVER){
        //show scores
        NSLog(@"GAME OVER");
    }
}

//}

- (void) showScore:(int) score Value:(int) value{
    for(SKLabelNode* l in self->scorePlace.children){
        if([l.name isEqual: @"scorePlaceCurrent"]){
            l.text = [NSString stringWithFormat:@"%d", score];
        }
    }
    for(SKLabelNode* l in self->valuePlace.children){
        if([l.name isEqual: @"valuePlaceCurrent"]){
            l.text = [NSString stringWithFormat:@"%d", value];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"restartButton"]) {
        NSLog(@"restarting...");
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
