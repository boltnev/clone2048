//
//  Board.m
//  clone2048
//
//  Created by Ilya Boltnev on 07/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import "Board.h"
#import "MyScene.h"


@implementation Board
@synthesize boardsize;
@synthesize db;


- (id) initWithSize:(int) size WithScene:(MyScene*) scene{
    if (self = [super init]) {
        self->scene = scene;
        /* Setup your scene here */
        
        self.currentScore = 0;
        self.currentValue = 0;
        
        
        self.db = [[DBManager alloc] initWithDatabaseFilename:@"data.sqlite3"];
        [self getMaxScores];
        [self addValueToScore:0];


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
        [self placeRandomSquare];
        [self placeRandomSquare];

        for (Piece* p in self->pieces){
            p.justCreated = NO;
        }
//
        [self->scene addChild:boardView];
    }
    return self;
}

- (void) getMaxScores{
    self.maxValue = 0;
    self.maxScore = 0;
    [self.db runQuery:[@"select max(score) from Scores" UTF8String]  isQueryExecutable:NO];
    for(int i=0; i < self.db.arrResults.count; i++){
        NSMutableArray * resultsRow = [self.db.arrResults objectAtIndex:i];
        NSString * maxScoreStr = [resultsRow objectAtIndex:i];
        self.maxScore = [maxScoreStr intValue];
    }
    [self.db runQuery:[@"select max(max_piece) from Scores" UTF8String] isQueryExecutable:NO];
    for(int i=0; i < self.db.arrResults.count; i++){
        NSMutableArray * resultsRow = [self.db.arrResults objectAtIndex:i];
        NSString * maxValueStr = [resultsRow objectAtIndex:i];
        self.maxValue = [maxValueStr intValue];
    }
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
            case 8:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.7 green:0.5 blue:0.5 alpha:1];
                break;
            case 16:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1];
                break;
            case 32:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.3 green:0.06 blue:0.6 alpha:1];
                break;
            case 64:
                label.fontSize = 40;
                square.color = [SKColor colorWithRed:0.9 green:0.7 blue:0.7 alpha:1];
                break;
            case 128:
                label.fontSize = 32;
                square.color = [SKColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
                break;
            case 256:
                label.fontSize = 32;
                square.color = [SKColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1];
                break;
            case 512:
                label.fontSize = 32;
                square.color = [SKColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:1];
                break;
            case 1024:
                label.fontSize = 28;
                square.color = [SKColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1];
                break;
            case 2048:
                label.fontSize = 28;
                square.color = [SKColor colorWithRed:0.1 green:0.5 blue:0.1 alpha:1];
                break;
            case 4096:
                label.fontSize = 28;
                square.color = [SKColor colorWithRed:0.2 green:0.7 blue:0.6 alpha:1];
                break;
            case 8192:
                label.fontSize = 28;
                square.color = [SKColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
                break;
            case 16384:
                label.fontSize = 24;
                square.color = [SKColor colorWithRed:0.1 green:0.8 blue:0.3 alpha:1];
                break;
            case 32768:
                label.fontSize = 24;
                square.color = [SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
                break;
            default:
                [NSException raise: @"Invalid square value" format: @"value %d is invalid", value];
        }
        
        NSLog(@"%@", NSStringFromCGPoint(position));
        
        label.position = CGPointMake(0, - (size - 40 /*label.fontSize*/) / 2 );
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

- (void) removePiece:(Piece*) piece{
    [self->pieces removeObject:piece];
    SKAction * sequence = [SKAction sequence:@[[SKAction waitForDuration:0.2], [SKAction removeFromParent]] ];
    [piece.sprite runAction:sequence];
}

- (void) addValueToScore:(int) value{
    self.currentScore += value;
    if(value > self.currentValue){
        self.currentValue = value;
    }
    
    int displayScore = MAX(self.currentScore, self.maxScore);
    int displayValue = MAX(self.currentValue, self.maxValue);
    [self->scene showScore:displayScore Value:displayValue];
}

- (void) joinPiece:(Piece*) topPiece With:(Piece*) bottomPiece{
    CGPoint position = topPiece.coords;
    int value = topPiece.value * 2;
    [self addValueToScore:value];
    [self removePiece:bottomPiece];
    [self removePiece:topPiece];
    [self placeSquareOnPosition:position withValue:value];
}
/* moves */

- (NSMutableArray *) neibPiecesToX:(int) i ToY:(int) j{
    NSMutableArray * result = [[NSMutableArray alloc ] init];
    Piece* currentPiece;
    if(i - 1 >= 0){
        currentPiece =[self getPieceOnPositionX:i-1 OnY:j];
        if(currentPiece != nil){
            [result addObject:currentPiece];
        }
    }
    if(i + 1 <= 3){
        currentPiece =[self getPieceOnPositionX:i+1 OnY:j];
        if(currentPiece != nil){
            [result addObject:currentPiece];
        }
    }
    if(j + 1 <= 3){
        currentPiece =[self getPieceOnPositionX:i OnY:j+1];
        if(currentPiece != nil){
            [result addObject:currentPiece];
        }
    }
    if(j - 1 <= 3){
        currentPiece =[self getPieceOnPositionX:i OnY:j-1];
        if(currentPiece != nil){
            [result addObject:currentPiece];
        }
    }
    return result;
}

- (BOOL) movesAvailable{
    for(int i = 0; i < 4;  i++){
        for(int j = 0; j < 4; j++){
            Piece * current = [self getPieceOnPositionX:i OnY:j];
            if(current == nil){
                return YES;
            }
            else{
                for(Piece *neib in [self neibPiecesToX:i ToY:j]){
                    if(neib.value == current.value){
                        return YES;
                    }
                }
            }
        }
    }
    
    return NO;
}

- (void) storeScores{
    NSString * query = [NSString stringWithFormat: @"INSERT INTO Scores (score, max_piece) VALUES (%d, %d)",
                        self.currentScore, self.currentValue];
    [self.db runQuery: [query UTF8String]  isQueryExecutable:YES];
}

- (enum GAMESTATE) coordsMoveA:(NSArray*)aCoords B:(NSArray*) bCoords Horizontal: (BOOL) horizontal{
    __block CGPoint position;
    __block Piece* currentPiece, *prevPiece;
    __block BOOL createNewPiece = false;
    
    if (![self movesAvailable]) {
        return GAMEOVER;
    }
    /* move in one Row */
    void (^moveRowOrCol)(NSNumber *i, NSNumber *j) = ^(NSNumber *i, NSNumber *j){
        currentPiece = [self getPieceOnPositionX:i.intValue OnY:j.intValue];
        if(currentPiece == nil){
            if(position.x == -1 && position.y == -1){
                position = [self getPositionOnX:i.intValue onY:j.intValue];
            }
        }
        else{
            if(prevPiece != nil){
                if(prevPiece.value == currentPiece.value && ! (currentPiece.justCreated || prevPiece.justCreated)){
                    SKAction *moveSquare = [SKAction moveTo:prevPiece.coords duration:0.2];
                    [currentPiece.sprite runAction:moveSquare];
                    [self joinPiece:currentPiece With:prevPiece];
                    createNewPiece = YES;
                    prevPiece = nil;
                    return;
                }
            }
            if(!(position.x == -1 && position.y == -1)){
                currentPiece.coords = position;
                SKAction *moveSquare = [SKAction moveTo:position duration:0.2];
                [currentPiece.sprite runAction:moveSquare];
                createNewPiece = YES;
            }
            prevPiece = currentPiece;
            position.x = position.y = -1;
        }
    };

    for(int k = 0; k < 4; k++ ){

        for (NSNumber *i in aCoords){
            prevPiece = nil;
            position.x = position.y = -1;
            for(NSNumber *j in bCoords){
                if(horizontal){
                    moveRowOrCol(j, i);
                }
                else{
                    moveRowOrCol(i, j);
                }
            }
        }
    }
    if(createNewPiece){
        [self placeRandomSquare];
    }
    for (Piece* p in self->pieces){
        p.justCreated = NO;
    }
    if ([self movesAvailable]) {
        return PLAYING;
    }else{
     	return GAMEOVER;
    }
}


- (enum GAMESTATE) rightMove{
    NSArray *aCoords = @[@0, @1, @2, @3];
    NSArray *bCoords = @[@3, @2, @1, @0];
    return [self coordsMoveA:aCoords B:bCoords Horizontal:YES];
}


- (enum GAMESTATE) leftMove{
    NSArray *aCoords = @[@0, @1, @2, @3];
    NSArray *bCoords = @[@0, @1, @2, @3];
    return [self coordsMoveA:aCoords B:bCoords Horizontal:YES];

}

- (enum GAMESTATE) upMove{
    NSArray *aCoords = @[@3, @2, @1, @0];
    NSArray *bCoords = @[@3, @2, @1, @0];
    return [self coordsMoveA:aCoords B:bCoords Horizontal:NO];
}

- (enum GAMESTATE) downMove{
    NSArray *aCoords = @[@3, @2, @1, @0];
    NSArray *bCoords = @[@0, @1, @2, @3];
    return [self coordsMoveA:aCoords B:bCoords Horizontal:NO];
}



@end
