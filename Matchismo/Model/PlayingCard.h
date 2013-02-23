//
//  PlayingCard.h
//  Matchismo
//
//  Created by bgbb on 2/13/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
