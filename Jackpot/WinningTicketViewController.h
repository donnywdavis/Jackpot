//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Donny Davis on 4/21/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WinningTicketViewControllerDelegate <NSObject>
@required

- (void)returnThePickedNumbers:(NSArray *)pickedNumbers;

@optional

- (void)sayThanksForTheNumbers;

@end

@interface WinningTicketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *checkTicketButton;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet id <WinningTicketViewControllerDelegate>delegate;

- (IBAction)generateTicket:(UIButton *)sender;
- (IBAction)checkTicket:(UIButton *)sender;

@end
