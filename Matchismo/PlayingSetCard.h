//
//  PlayingSetCard.h
//  Matchismo
//
//  Created by bgbb on 3/6/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingSetCard : PlayingCard

//@property (strong, nonatomic) NSString *suit;
//@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *color;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
