//
//  PlayingCard.m
//  Matchismo
//
//  Created by bgbb on 2/13/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
@synthesize rank = _rank;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSString *matchType ;
//    if ([otherCards count] == 1) {
//        PlayingCard *otherCard = [otherCards lastObject];
//        if ([otherCard.suit isEqualToString:self.suit]){
//            score = 1;
//        } else if (otherCard.rank == self.rank){
//            score = 4;
//        }
//    }
    for (PlayingCard *otherCard in otherCards){
        
        if (!matchType){
            if ([otherCard.suit isEqualToString:self.suit]){
                score += 1;
                matchType = @"suit";
            } else if (otherCard.rank == self.rank){
                score += 2;
                matchType = @"rank";
            } else {
                score = 0;
                break;
            }            
        }else if ([matchType isEqualToString:@"suit"]){
            if ([otherCard.suit isEqualToString:self.suit]){
                score += 1;
            } else {
                score = 0;
                break;
            }
        }else if ([matchType isEqualToString:@"rank"]){
            if (otherCard.rank == self.rank){
                score += 2;
            } else {
                score = 0;
                break;
            }
        }
    }
    
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit:@"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return[self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
