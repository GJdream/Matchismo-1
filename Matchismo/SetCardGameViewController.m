//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by bgbb on 3/5/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardMatchingGame.h"
#import "PlayingSetCard.h"
#import "PlayingSetCardDeck.h"
#import <QuartzCore/QuartzCore.h>

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
    //NSLog(@"updateUI");
    for (UIButton *cardButton in self.cardButtons){
        PlayingSetCard *card = (PlayingSetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        //NSLog(@"card contains %@", card.contents);
        NSMutableString *content = [[NSMutableString alloc] init];
        //create string content
        for (int i = 0; i < card.rank; i++){
            [content appendString: card.suit];
        }
        //dictionary object for attribute
        NSMutableDictionary *cardAttr = [[NSMutableDictionary alloc] init];
        
        //color
        UIColor *targetColor = [[UIColor alloc] init];
        if ([card.color isEqualToString: @"red"]) {
            targetColor = [UIColor redColor];
        }else if ([card.color isEqualToString: @"green"]) {
            targetColor = [UIColor greenColor];
        }else if ([card.color isEqualToString: @"blue"]){
            targetColor = [UIColor blueColor];
        }
        [cardAttr setObject:targetColor forKey:NSForegroundColorAttributeName];
        
        //shade
        if ([card.shading isEqualToString: @"solid"]){
            //do nothihg
        }else if ([card.shading isEqualToString: @"clear"]){
            [cardAttr setObject:[NSNumber numberWithFloat:3.0] forKey:NSStrokeWidthAttributeName];
        }else if ([card.shading isEqualToString: @"striped"]){
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
        cardButton.alpha = card.isFaceUp ? 0.3 : 1.0;

        //to mark matched cards
        cardButton.alpha = card.isUnplayable ? 0.0 : cardButton.alpha;

        //NSLog(@"card content:%@ unplayable:%c isFaceUp:%c",card.contents,
        //      card.isUnplayable, card.isFaceUp);
        /** this makes sharp rectangular shape.. not pretty.. turn off for now
         //setting border if card is faceUp
        if (card.isFaceUp){
            
            [[cardButton layer] setBorderWidth:2.0f];
            [[cardButton layer] setBorderColor:[UIColor blackColor].CGColor];
            NSLog(@"card face up:%@", card.contents);
        }else{
            [[cardButton layer] setBorderWidth:0.0f] ;
        }**/
        
    }
    
//    NSLog(@"flips updated to %d", self.flipCount);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
