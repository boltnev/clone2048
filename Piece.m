//
//  Piece.m
//  clone2048
//
//  Created by Ilya Boltnev on 07/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import "Piece.h"

@implementation Piece

@synthesize coords;

- (id) initWithValue:(int) value Coords:(CGPoint) coords WithSprite:(SKSpriteNode *)sprite{
    if(self = [super init]){
        self->value = value;
        self.coords = coords;
        self->sprite = sprite;
        self->justCreated = YES;
    }
    return self;
}





@end
