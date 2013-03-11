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

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flips;
@property (nonatomic) int flippedCount;
@property (strong, nonatomic) SetCardMatchingGame *game;
@end

@implementation SetCardGameViewController

- (SetCardMatchingGame *)game
{
    if (!_game)
        _game = [[SetCardMatchingGame alloc]
                 initWithCardCount:self.setCardButtons.count
                 usingDeck:[[PlayingSetCardDeck alloc] init]];
    return _game;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
