//
//  CardGameViewController.m
//  Matchismo
//
//  Created by bgbb on 2/11/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flippedLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegm;

@property (nonatomic) int flippedCount;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController


- (CardMatchingGame *)game
{
    if (!_game)
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:self.cardButtons.count
                 usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}


- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameStatusLabel.text = [NSString stringWithFormat:@"%@", self.game.gameStatus];
    self.modeSegm.enabled = !self.game.isGameOn;
    self.flippedLabel.text = [NSString stringWithFormat:@"Flipped: %d", self.flippedCount];
}


- (void) setFlippedCount:(int)flippedCount{
    _flippedCount = flippedCount;
    NSLog(@"flips updated to %d", self.flippedCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.flippedCount++;
    [self updateUI];
}

- (IBAction)dealButton {
    
    self.game = nil;
    self.flippedCount = 0;
    
    [self updateUI];
}


- (IBAction)selectModeSegm {
    
    if (self.modeSegm.selectedSegmentIndex == 0){
        self.game.mode = 2;
        NSLog(@" 2 card mode");
    }else if (self.modeSegm.selectedSegmentIndex == 1){
        self.game.mode = 3;
        NSLog(@" 3 card mode");
    }
}





@end
