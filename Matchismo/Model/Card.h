//
//  CardGame.h
//  Matchismo
//
//  Created by bgbb on 2/13/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
@property (nonatomic, getter = isChanged) BOOL changed;


//- (int)match:(Card *)card;

- (int)match:(NSArray *)otherCards;

@end
