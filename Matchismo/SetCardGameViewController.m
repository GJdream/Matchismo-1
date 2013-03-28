//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by bgbb on 3/5/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingSetCard.h"
#import "PlayingSetCardDeck.h"
#import "CardMatchingGame.h"
//#import <QuartzCore/QuartzCore.h>

@interface SetCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game){
        //reusing CardMatchingGame
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:self.cardButtons.count
                 usingDeck:[[PlayingSetCardDeck alloc] init]];
        //as set card is 3 card mode, setting this value as 3
        _game.mode = 3;
    }
    return _game;
}


- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (void)updateUI
{
    NSMutableAttributedString *gameStatusAttrStr = nil;
    if (self.game || self.game.gameStatus){
        //begin with status prefix
        NSRange range= [self.game.gameStatus rangeOfString:@"! "];
        
        if (range.length){
           //this will get Yes! No! Up!
           NSString *substring = [self.game.gameStatus substringToIndex:range.location+2];
           gameStatusAttrStr = [[NSMutableAttributedString alloc] initWithString:substring];
        }
    }

    
    for (UIButton *cardButton in self.cardButtons){
        PlayingSetCard *card = (PlayingSetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        //NSLog(@"card contains %@", card.contents);
        // no change then do nothing
        if (!card.isChanged){
            continue;
        }
        NSMutableString *content = [[NSMutableString alloc] init];
        //create string content
        for (int i = 0; i < card.rank; i++){
            [content appendString: card.suit];
        }
        //dictionary object for attribute
        NSMutableDictionary *cardAttr = [[NSMutableDictionary alloc] init];
        
        //color
        UIColor *targetColor = [[UIColor alloc] init];
        if ([card.color isEqualToString: COLOR_RED]) {
            targetColor = [UIColor redColor];
        }else if ([card.color isEqualToString: COLOR_GREEN]) {
            targetColor = [UIColor greenColor];
        }else if ([card.color isEqualToString: COLOR_BLUE]){
            targetColor = [UIColor blueColor];
        }
        [cardAttr setObject:targetColor forKey:NSForegroundColorAttributeName];
        
        //shade
        if ([card.shading isEqualToString: SHADE_SOLID]){
            //do nothihg
        }else if ([card.shading isEqualToString: SHADE_CLEAR]){
            [cardAttr setObject:[NSNumber numberWithFloat:3.0] forKey:NSStrokeWidthAttributeName];
        }else if ([card.shading isEqualToString: SHADE_STRIPED]){
            [cardAttr setObject:@-5 forKey:
             NSStrokeWidthAttributeName];
            [cardAttr setObject:targetColor forKey:
             NSStrokeColorAttributeName];
            [cardAttr setObject:[targetColor colorWithAlphaComponent:0.1] forKey:
                NSForegroundColorAttributeName];
        }
        NSMutableAttributedString *cardContent =
        [[NSMutableAttributedString alloc] initWithString:content attributes:cardAttr];
        
        [cardButton setAttributedTitle:cardContent forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;

        //to mark selected cards
        cardButton.backgroundColor = card.isFaceUp ? [UIColor grayColor] : [UIColor whiteColor] ;

        //to mark matched cards
        cardButton.alpha = card.isUnplayable ? 0.0 : cardButton.alpha;
        
        //let's add this attribute to status and space
        if (gameStatusAttrStr){ //when gameStatusAttrStr is not nill
           [gameStatusAttrStr appendAttributedString:cardContent];
           [gameStatusAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        //reset for next run
        card.changed = NO;
        
    }
    //only when gameStatus is not nil change gameStatusLabel
    if (gameStatusAttrStr){
       self.gameStatusLabel.attributedText = gameStatusAttrStr;
    }
//    NSLog(@"flips updated to %d", self.flipCount);

}


@end
