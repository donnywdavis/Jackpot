//
//  Ticket.h
//  Jackpot
//
//  Created by Donny Davis on 4/20/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (assign) BOOL winner;
@property (copy, nonatomic) NSString *payout;

+ (instancetype)ticketUsingQuickPick;
+ (instancetype)ticketUsingArray:(NSArray *)picks;

- (void)compareWithTicket:(Ticket *)anotherTicket;
- (NSArray *)picks;

@end
