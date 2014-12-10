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
#import "DBManager.h"

enum GAMESTATE{GAMEOVER, PLAYING};

@interface Board : NSObject{
    SKScene *scene;
    NSMutableArray *pieces;
    SKShapeNode *boardView;
    
}

@property int boardsize;
@property DBManager *db;

-(id) initWithSize:(int) size WithScene:(SKScene*) scene;

- (CGPoint) getPositionOnX: (int) i
                       onY: (int) j;

- (enum GAMESTATE) rightMove;

- (enum GAMESTATE) leftMove;

- (enum GAMESTATE) upMove;

- (enum GAMESTATE) downMove;

@end
