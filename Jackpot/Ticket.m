//
//  Ticket.m
//  Jackpot
//
//  Created by Donny Davis on 4/20/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "Ticket.h"

@interface Ticket() {
    
    NSMutableArray *picks;
    
}

@end


@implementation Ticket

- (instancetype)init {
    self = [super init];
    if (self) {
        picks = [NSMutableArray array]; // another option to [[alloc] init]
        self.winner = NO;
        self.payout = 0;
        self.ticketPrice = 1;
    }
    return self;
}

+ (instancetype)ticketUsingQuickPick {
    
    Ticket *aTicket = [[Ticket alloc] init];
    
    do {
        [aTicket createPick];
    } while (aTicket.picks.count < 6);
    
    // sort the picks before returning
    [aTicket sortPicks];
    
    return aTicket;
    
}

+ (instancetype)ticketUsingArray:(NSArray *)picks {
    
    Ticket *ticket = [[Ticket alloc] init];
    
    [ticket storeTheArrayIntoPicks:picks];
    [ticket sortPicks];
    
    return ticket;
}

- (void)storeTheArrayIntoPicks:(NSArray *)array {
    picks = [array mutableCopy];
}

- (void)createPick {
    int pickInt = arc4random() % 54 + 1;
    NSNumber *pickNumber = [NSNumber numberWithInt:pickInt];
    
    BOOL dontAdd = NO;
    for (NSNumber *numberInArray in picks ) {
        if (numberInArray.intValue == pickInt) {
            dontAdd = YES;
        }
    }
    
    if (!dontAdd) {
        [picks addObject:pickNumber];
    }
}

- (NSArray *)picks {
    return [picks copy];
}

- (void)sortPicks {
    
    picks = [[picks sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
}

- (void)compareWithTicket:(Ticket *)anotherTicket {
    NSArray *possibleWinningNumbers = anotherTicket.picks;
    int matchCount = 0;
    
    for (NSNumber *ourNumber in picks) {
        for (NSNumber *theirNumber in possibleWinningNumbers) {
            if (ourNumber.intValue == theirNumber.intValue) {
                matchCount += 1;
            }
        }
    }
    
    switch (matchCount) {
        case 1:
            self.winner = YES;
            self.payout = 1;
            break;
            
        case 2:
            self.winner = YES;
            self.payout = 1;
            break;
            
        case 3:
            self.winner = YES;
            self.payout = 5;
            break;
        
        case 4:
            self.winner = YES;
            self.payout = 10;
            break;
            
        case 5:
            self.winner = YES;
            self.payout = 100;
            break;
            
        case 6:
            self.winner = YES;
            self.payout = 1000;
            break;
            
        default:
            self.winner = NO;
            self.payout = 0;
            break;
    }
}

- (NSString *)description {
//    NSString *descriptionFormat = [[NSString alloc] init];
//    for (NSNumber *pick in picks) {
//        <#statements#>
//    }
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", picks[0], picks[1], picks[2], picks[3], picks[4], picks[5]];
}

@end
