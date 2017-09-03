//
//  MyScene.h
//  clone2048
//

//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"

@interface MyScene : SKScene{
    UISwipeGestureRecognizer *swipeRightGesture;
    UISwipeGestureRecognizer *swipeLeftGesture;
    UISwipeGestureRecognizer *swipeUpGesture;
    UISwipeGestureRecognizer *swipeDownGesture;
    SKShapeNode *scorePlace;
    SKShapeNode *valuePlace;
}

@property Board *board;

- (void) showScore:(int) score Value:(int) value;

@end
