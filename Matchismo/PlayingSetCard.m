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
@synthesize suit = _suit;
@synthesize rank = _rank;

- (id)init
{
    self = [super init];
    return self;
}

+ (NSArray *)validSuits{
    return @[SUIT_DIAMOND,SUIT_CIRCLE, SUIT_SQUARE];
}
+ (NSUInteger)maxRank{
    return 3;
}
+ (NSArray *)validShadings{
    return @[SHADE_SOLID, SHADE_CLEAR, SHADE_STRIPED];
}
+ (NSArray *)validColors;{
    return @[COLOR_RED, COLOR_GREEN, COLOR_BLUE];
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

- (int) matchingCount :(NSMutableDictionary *) propDC{
    // now let's find if it has 3 different value or same value of each type
    NSEnumerator *keyEnum;
    NSString *key;
    keyEnum = [propDC keyEnumerator];
    NSInteger val;
    int score = 0;
    // val will be either 0, 1 or 2
    // 2 will disqualify this set immediately
    while (key = [keyEnum nextObject]){
        val = [[propDC valueForKey:key] intValue];
        NSLog(@"value:%d for key %@",val, key);
        if (val == 2){
            //non matching set. disqualified.. move to next property
            break;
        }
    }
    // if no 2 then it qualifies
    // as at this point, we are going to see 1 or 2
    if (val != 2){
        score = 3;
    }
    NSLog(@"matchingCount score:%d", score);
    return score;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    //NSString *matchType ;
    
    if ([otherCards count] < 2){
        score = 1;
        return score;
    }

    NSMutableDictionary *suitDC  = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *shadeDC = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *colorDC = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *rankDC  = [[NSMutableDictionary alloc] init];
    // do it for self first
    
    [suitDC setValue:@1 forKey:  self.suit];
    [shadeDC setValue:@1 forKey: self.shading];
    [colorDC setValue:@1 forKey: self.color];
    [rankDC setValue:@1 forKey: [NSString stringWithFormat:@"%d", self.rank]];
    NSInteger val;
    
    for (PlayingSetCard *otherCard in otherCards) {
        val = [[suitDC valueForKey: otherCard.suit] intValue];
        val ++;
        
        [suitDC setValue:[NSNumber numberWithInt:val] forKey:otherCard.suit];
        
        val = [[shadeDC valueForKey:otherCard.shading] intValue];
        val ++;
        [shadeDC setValue:[NSNumber numberWithInt:val] forKey:otherCard.shading];
        
        val = [[colorDC valueForKey:otherCard.color] intValue];
        val ++;
        [colorDC setValue:[NSNumber numberWithInt:val] forKey:otherCard.color];
        
        val = [[rankDC valueForKey:[NSString stringWithFormat:@"%d", otherCard.rank] ] intValue];
        val ++;
        [rankDC setValue:[NSNumber numberWithInt:val] forKey:[NSString stringWithFormat:@"%d", otherCard.rank]];
        
    }// end of for loop
    
    NSLog(@"suit");

    score = [self matchingCount:suitDC];
    // if it is zero, this set was disqualified
    if (!score){
        return score;
    }
    
    NSLog(@"shade");

    score = [self matchingCount:shadeDC];
    
    if (!score){
        return score;
    }

    NSLog(@"color");
    
    score = [self matchingCount:colorDC];
    
    if (!score) {
        return score;
    }

    NSLog(@"rank");
    
    score = [self matchingCount:rankDC];
    
    return score;
}



- (NSString *)contents
{
    NSString *content = [NSString stringWithFormat:@"%@ %d %@ %@",
                       self.suit, self.rank, self.color, self.shading];
    return content;
    
}





@end
