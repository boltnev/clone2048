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
//
//        board = [SKShapeNode node];
//        
//        boardsize = self.size.width - self.size.width * 0.1;
//        
//        CGRect boardshape = CGRectMake(-boardsize / 2,-boardsize / 2, boardsize, boardsize);
//        
//        [board setPath:CGPathCreateWithRoundedRect(boardshape, 15, 15, nil)];
//        board.position = CGPointMake(self.size.width / 2, self.size.height / 2);
//        board.strokeColor =  board.fillColor = [SKColor colorWithRed:255 / 255.0
//                                                               green:207 / 255.0
//                                                                blue:74 / 255.0
//                                                               alpha:0.8];
//        [self placeSquares];
//        
//        [self placeRandomSquare];
//        
//        [self addChild:board];
        
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
    switch(recognizer.direction){
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"Right swipe");
            [self.board rightMove];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Left swipe");
            [self.board leftMove];
            break;
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"Up swipe");
            [self.board upMove];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"Down swipe");
            [self.board downMove];
            break;
        default:
            NSLog(@"Unknown swipe");
    }
}

//}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
