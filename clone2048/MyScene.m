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



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
