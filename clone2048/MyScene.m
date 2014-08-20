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
@synthesize boardsize;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
        
        board = [SKShapeNode node];
        
        boardsize = self.size.width - self.size.width * 0.1;
        
        CGRect boardshape = CGRectMake(-boardsize / 2,-boardsize / 2, boardsize, boardsize);
        
        [board setPath:CGPathCreateWithRoundedRect(boardshape, 15, 15, nil)];
        board.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        board.strokeColor =  board.fillColor = [SKColor colorWithRed:255 / 255.0
                                                               green:207 / 255.0
                                                                blue:74 / 255.0
                                                               alpha:0.8];
        [self placeSquares];
        
        [self placeRandomSquare];
        
        [self addChild:board];
        
    }
    return self;
}


- (void) placeSquares{
    
    for(int i = 0; i < 4;  i++){
        
        for(int j = 0; j < 4; j++){
            
            [self placeSquareOnPosition: [self getPositionOnX:i onY:j]
                              withValue:0];
            
        
        }
    }
    
    
    
}

- (CGPoint) getPositionOnX: (int) i
                       onY: (int) j
{
    i = -3 + i * 2;
    j = -3 + j * 2;
    
    return CGPointMake(  i * (boardsize / 8.0)  , j * (boardsize / 8.0));
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
    [board addChild:square];
}

- (void) placeRandomSquare{
    int i = arc4random() % 4;
    int j = arc4random() % 4;
    
    int value = 0x1 << (arc4random() % 2 + 1);
    
    NSLog([@(value) stringValue]);
    
    CGPoint position = [self getPositionOnX:i onY:j];
    
    [self placeSquareOnPosition: position withValue:value];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
