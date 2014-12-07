//
//  Board.h
//  clone2048
//
//  Created by Ilya Boltnev on 07/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Piece.h"

@interface Board : NSObject{
    SKScene *scene;
    NSMutableArray *pieces;
    SKShapeNode *boardView;
    
}
@property int boardsize;

-(id) initWithSize:(int) size WithScene:(SKScene*) scene;

- (CGPoint) getPositionOnX: (int) i
                       onY: (int) j;


@end
