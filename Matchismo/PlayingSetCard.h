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

#define SUIT_DIAMOND @"◆"
#define SUIT_CIRCLE  @"●"
#define SUIT_SQUARE  @"■"

#define SHADE_SOLID  @"solid"
#define SHADE_CLEAR  @"clear"
#define SHADE_STRIPED @"striped"

#define COLOR_RED    @"red"
#define COLOR_GREEN  @"green"
#define COLOR_BLUE   @"blue"

#define NUMBER_ONE   @1
#define NUMBER_TWO   @2
#define NUMBER_THREE @3

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
