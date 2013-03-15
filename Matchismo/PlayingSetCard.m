//
//  PlayingSetCard.m
//  Matchismo
//
//  Created by bgbb on 3/6/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "PlayingSetCard.h"
#import "UIKit/UIColor.h"

@implementation PlayingSetCard
//@property (strong, nonatomic) NSString *suit;
//@property (nonatomic) NSUInteger rank;
//@property (nonatomic) NSString *shading;
//@property (nonatomic) NSString *color;
@synthesize suit = _suit;
@synthesize rank = _rank;

- (id)init
{
    self = [super init];
    return self;
}

+ (NSArray *)validSuits{
    return @[@"◆",@"●", @"■"];
}
+ (NSUInteger)maxRank{
    return 3;
}
+ (NSArray *)validShadings{
    return @[@"solid", @"clear", @"striped"];
}
+ (NSArray *)validColors;{
    return @[ @"red", @"green", @"blue"];
}

- (void) setColor:(NSString *) color{
    if ([[PlayingSetCard validColors] containsObject:color]){
        _color = color;
    }
}

- (void) setShading:(NSString *) shading{
    if ([[PlayingSetCard validShadings] containsObject:shading]){
        _shading = shading;
    }
}

- (void) setSuit:(NSString *) suit{
    if ([[PlayingSetCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingSetCard maxRank]) {
        _rank = rank;
    }
}


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    return score;
}

- (NSString *)contents
{
    NSString *content = [NSString stringWithFormat:@"%@ %d %@ %@",
                       self.suit, self.rank, self.color, self.shading];
    return content;
    
}





@end
