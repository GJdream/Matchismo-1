//
//  CardGameViewController.h
//  Matchismo
//
//  Created by bgbb on 2/11/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController

- (IBAction)dealButton;

- (IBAction)flipCard:(UIButton *)sender;

- (void) setCardButtons:(NSArray *)cardButtons;
@end
