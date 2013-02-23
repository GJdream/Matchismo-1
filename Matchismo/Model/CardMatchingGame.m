//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by bgbb on 2/18/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame()
@property (nonatomic) int score;
@property (nonatomic) NSString *gameStatus;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) BOOL isGameOn;
@end

@implementation CardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALITY 2
#define FLIP_COST 1


- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.gameStatus = nil;
    int flippedCards = 0;
    int matchScore = 0;
    
    if(!self.isGameOn) self.isGameOn = YES;
    
    if(card.isUnplayable) return;
    
    if(!card.isFaceUp) {
        flippedCards = 1;

        for(Card *otherCard in self.cards){
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                flippedCards++;
                
                int tempScore = [card match:@[otherCard]];

                if (tempScore) {
                    matchScore += tempScore;
                
                    if (flippedCards >= self.mode)
                        break;
                } else {
                    matchScore = 0;
                    break;
                    
             //       otherCard.faceUp = NO;
             //       self.score -= MISMATCH_PENALITY;
             //       self.gameStatus = [NSString stringWithFormat:@"%@ & %@ don't match! %d points penalty", card.contents, otherCard.contents,
               //                        (MISMATCH_PENALITY+FLIP_COST)];
                    
                }
                //break; to support 3 matching cards
            }
        }// end of for loop
        NSLog(@"flippedCards: %d self.mode: %d", flippedCards, self.mode);
        
        // there were more than one card flipped
        if (flippedCards >= self.mode && matchScore){
            
                card.unplayable = YES;
                self.score += matchScore * MATCH_BONUS;
                self.gameStatus = [NSString stringWithFormat:@"Matching %@",card.contents];
                
                for(Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.unplayable = YES;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                    }
                }
                self.gameStatus = [NSString stringWithFormat:@" %@ for %d points", self.gameStatus, (matchScore*MATCH_BONUS-FLIP_COST)];
            
        }
        if (!matchScore && flippedCards > 1){
                self.score -= MISMATCH_PENALITY;
                self.gameStatus = [NSString stringWithFormat:@"%@",card.contents];
                
                for(Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.faceUp = NO;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                    }
                }
                self.gameStatus = [NSString stringWithFormat:@"%@ don't match! %d points penalty", self.gameStatus, (MISMATCH_PENALITY+FLIP_COST)];
        }
        
        if (flippedCards == 1){//if there is no other card flipped
            self.gameStatus = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }
        self.score -= FLIP_COST;
        card.faceUp = !card.isFaceUp;
    }
    NSLog(@"card contents: %@ at index %d faceUp %c", card.contents, index, card.isFaceUp);
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck
{
    self = [super init];
    self.score = 0;
    self.gameStatus = @"Let's begin";
    self.isGameOn = NO;
    
    if (self) {
        for (int i = 0; i< count;i++){
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
        }
        
    }
    return self;
}

@end
