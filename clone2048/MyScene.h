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
}

@property Board *board;

@end
