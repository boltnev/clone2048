//
//  Piece.h
//  clone2048
//
//  Created by Ilya Boltnev on 07/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Piece : NSObject
{
    SKSpriteNode *sprite;
    int value;
    BOOL justCreated;
}
@property CGPoint coords;

- (id) initWithValue:(int) value Coords:(CGPoint) coords WithSprite:(SKSpriteNode *) sprite;

@end
