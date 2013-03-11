//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by bgbb on 3/8/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "Card.h"
#import "Deck.h"

@interface SetCardMatchingGame()
@property (nonatomic) int score;
@property (nonatomic) NSString *gameStatus;
@property (nonatomic) BOOL isGameOn;
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation SetCardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALITY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init] ;
    self.gameStatus = nil;
    int matchScore = 0;
    
    if(!self.isGameOn) self.isGameOn = YES;
    
    if(card.isUnplayable) return;
    
    if(!card.isFaceUp) {
        
        for(Card *otherCard in self.cards){
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                [selectedCards addObject:otherCard];
                
                if ([selectedCards count]>=self.mode-1){
                    matchScore = [card match:@[otherCard]];
                    break;
                }
                
            }
        }// end of for loop
        
        // there were more than one card opened and they matched
        if ([selectedCards count] >= self.mode-1 ){
            
            if (matchScore){
            
               card.unplayable = YES;
               self.score += matchScore * MATCH_BONUS;
               self.gameStatus = [NSString stringWithFormat:@"Matching %@",card.contents];
            
               for(Card *otherCard in selectedCards) {
                 if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    otherCard.unplayable = YES;
                    self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                 }
               }
               self.gameStatus = [NSString stringWithFormat:@" %@ for %d points", self.gameStatus, (matchScore*MATCH_BONUS-FLIP_COST)];
            }else{
                self.score -= MISMATCH_PENALITY;
                self.gameStatus = [NSString stringWithFormat:@"%@",card.contents];
                
                for(Card *otherCard in selectedCards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.faceUp = NO;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                    }
                }
                self.gameStatus = [NSString stringWithFormat:@"%@ don't match! %d points penalty", self.gameStatus, (MISMATCH_PENALITY+FLIP_COST)];
            }
        }
        
        if ([selectedCards count] == 0){//if there is no other card flipped
            self.gameStatus = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }
        self.score -= FLIP_COST;
        card.faceUp = !card.isFaceUp;
    }
    NSLog(@"card contents: %@ at index %d faceUp %c", card.contents, index, card.isFaceUp);
    
}



@end
