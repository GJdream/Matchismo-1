//
//  PlayingSetCardDeck.m
//  Matchismo
//
//  Created by bgbb on 3/8/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "PlayingSetCardDeck.h"
#import "PlayingSetCard.h"

@implementation PlayingSetCardDeck

- (id)init
{
    self = [super init];
    
    if (self){
        for(NSString *suit in [PlayingSetCard validSuits]){
            for (NSUInteger rank = 1; rank<=[PlayingSetCard maxRank]; rank++){
                for (NSString *shading in [PlayingSetCard validShadings]) {
                    for (NSString *color in [PlayingSetCard validColors]){
                        PlayingSetCard *card = [[PlayingSetCard alloc] init];
                        card.suit = suit;
                        card.rank = rank;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:YES];                        
                    }
                }
            }
        }
        
    }
    return self;
}

@end
