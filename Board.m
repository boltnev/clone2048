//
//  Board.m
//  clone2048
//
//  Created by Ilya Boltnev on 07/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import "Board.h"


@implementation Board
@synthesize boardsize;



- (id) initWithSize:(int) size WithScene:(SKScene*) scene{
    if (self = [super init]) {
        self->scene = scene;
        /* Setup your scene here */
        
        self->pieces = [[NSMutableArray alloc ] init];
        
        self->scene.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
        
        self->boardView = [SKShapeNode node];
        
        self->boardsize = size - size * 0.1;
        
        CGRect boardshape = CGRectMake(-boardsize / 2,-boardsize / 2, boardsize, boardsize);
        
        [self->boardView setPath:CGPathCreateWithRoundedRect(boardshape, 15, 15, nil)];
        self->boardView.position = CGPointMake( self->scene.size.width / 2, self->scene.size.height / 2);
        self->boardView.strokeColor =  self->boardView.fillColor = [SKColor colorWithRed:255 / 255.0
                                                               green:207 / 255.0
                                                                blue:74 / 255.0
                                                               alpha:0.8];
        [self placeDefaultSquares];
//        [self placeSquares];
//        
        [self placeRandomSquare];
        [self placeRandomSquare];

//
        [self->scene addChild:boardView];
        
    }
    return self;
}


- (void) placeSquareOnPosition: (CGPoint) position
                     withValue: (int) value{
    
    int size = boardsize / 4;
    
    SKSpriteNode * square = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor]
                                                         size:CGSizeMake(size - 15, size -15)];
    square.position = position;
    
    if(value > 0){
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        label.text = [@(value) stringValue];
        switch (value) {
            case 2:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.7 green:0.3 blue:0.7 alpha:1];
                break;
            case 4:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.3 green:0.7 blue:0.7 alpha:1];
                break;
            default:
                [NSException raise: @"Invalid square value" format: @"value %d is invalid", value];
        }
        
        NSLog(@"%@", NSStringFromCGPoint(position));
        
        label.position = CGPointMake(0, - (size - label.fontSize) / 2 );
        [square addChild: label];
    }
    Piece* newPeace = [[Piece alloc] initWithValue:value Coords:position WithSprite:square];
    
    [self->pieces addObject:newPeace];
    
    [self->boardView addChild:square];
}


- (void) placeDefaultSquareOnPosition: (CGPoint) position{
    
    int size = self->boardsize / 4;
    
    SKSpriteNode * square = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor]
                                                         size:CGSizeMake(size - 15, size -15)];
    square.position = position;
    
    [self->boardView addChild:square];
}


- (CGPoint) getPositionOnX: (int) i
                       onY: (int) j
{
    i = -3 + i * 2;
    j = -3 + j * 2;
    
    return CGPointMake(  i * (self->boardsize / 8.0)  , j * (self->boardsize / 8.0));
}


-(Piece*) getPieceOnPositionX:(int) i OnY:(int) j{
    for(Piece* piece in self->pieces){
        if(CGPointEqualToPoint(piece.coords, [self getPositionOnX:i onY:j])){
            return piece;
        }
    }
    return nil;
}

- (void) placeRandomSquare{
    int i;
    int j;
    i = arc4random() % 4;
    j = arc4random() % 4;
    
    while ([self getPieceOnPositionX:i OnY:j] != nil) {
        i = arc4random() % 4;
        j = arc4random() % 4;
    }
    
    int value = 0x1 << (arc4random() % 2 + 1);

    NSLog([@(value) stringValue]);

    CGPoint position = [self getPositionOnX:i onY:j];

    [self placeSquareOnPosition: position withValue:value];

}


- (void) placeDefaultSquares{

    for(int i = 0; i < 4;  i++){

        for(int j = 0; j < 4; j++){

            [self placeDefaultSquareOnPosition:[self getPositionOnX:i onY:j]];

        }
    }
}


@end
