//
//  CardGame.m
//  Matchismo
//
//  Created by bgbb on 2/13/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

// the following 4 can be omitted
//- (BOOL)isFaceUp
//{
//    return _faceUp;
//}

//- (void)isFaceUp:(BOOL)faceUp
//{
//    _faceUp = faceUp;
//}

//- (BOOL)isUnplayable
//{
//    return _unplayable;
//}

//- (void)isUnplayable:(BOOL)unplyable
//{
//    _unplayable = unplyable;
//}

//- (int)match:(Card *)card
//{
//    int score = 0;
    
//    if ([card.content isEqualToString:self.content]) {
//        score = 1;
//    }
    
//    return score;
//}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
      if ([card.contents isEqualToString:self.contents]) {
         score = 1;
      }
    }
    
    return score;
    
}


@end
