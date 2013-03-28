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
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init] ;
    self.gameStatus = nil;
    int matchScore = 0;
    
    if(!self.isGameOn) self.isGameOn = YES;
    
    if(card.isUnplayable) return;

    NSLog(@"mode:%d", self.mode);

    if(!card.isFaceUp) {
        //first set changed
        card.changed = YES;
        
        for(Card *otherCard in self.cards){
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                [selectedCards addObject:otherCard];
                otherCard.changed = YES;
                /**
                if ([selectedCards count]>=self.mode-1){
                    matchScore = [card match:@[otherCard]];
                    break;
                }**/
                
            }
        }// end of for loop

        if ([selectedCards count]>0){
           matchScore = [card match:selectedCards];
        
           // there were more than one card opened and they matched
           if ( matchScore){
            BOOL isUnPlayable = NO;
               
               // if it reached max open count
              if ([selectedCards count] >= self.mode-1){
                 card.unplayable = YES;
                 self.score += matchScore * MATCH_BONUS;
                 self.gameStatus = [NSString stringWithFormat:@"Yes! %@",card.contents];
                 isUnPlayable = YES;
                 
              }else{ // still more to go
                  self.score += matchScore;
                  self.gameStatus = [NSString stringWithFormat:@"Up! %@", card.contents];
                  isUnPlayable = NO;
              }
            
             for(Card *otherCard in selectedCards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    otherCard.unplayable = isUnPlayable;
                    self.gameStatus = [self.gameStatus stringByAppendingFormat:@" %@",otherCard.contents];
                }
             }
            self.gameStatus = [NSString stringWithFormat:@" %@ for %d points", self.gameStatus, (self.score-FLIP_COST)];
            
           }else{
                self.score -= MISMATCH_PENALITY;
                self.gameStatus = [NSString stringWithFormat:@"No! %@",card.contents];
               
                for(Card *otherCard in selectedCards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.faceUp = NO;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                    }
                }
                self.gameStatus = [NSString stringWithFormat:@"%@ %d points off", self.gameStatus, (MISMATCH_PENALITY+FLIP_COST)];
            }
        }else{//if there is no other card flipped
            self.gameStatus = [NSString stringWithFormat:@"Up! %@", card.contents];
        }

     self.score -= FLIP_COST;
     card.faceUp = !card.isFaceUp;
    
     NSLog(@"card contents: %@ at index %d faceUp %c matchScore %d", card.contents, index, card.isFaceUp, matchScore);
    }
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
    self.mode = 2;
    
    if (self) {
        for (int i = 0; i< count;i++){
            Card *card = [deck drawRandomCard];
            card.changed = YES;
            
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
