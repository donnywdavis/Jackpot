//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Donny Davis on 4/21/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "WinningTicketViewController.h"
#import "Ticket.h"

@interface WinningTicketViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSMutableArray *pickedNumbers;
    BOOL hasPickedAllNumbers;
    
}

- (BOOL)allNumbersPicked;

@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    hasPickedAllNumbers = NO;
    pickedNumbers = [@[[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0]] mutableCopy];
    self.checkTicketButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)allNumbersPicked {
    for (NSNumber *pickedNumber in pickedNumbers) {
        if ([pickedNumber isEqualToNumber:@0]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Button actions

- (IBAction)generateTicket:(UIButton *)sender {
    Ticket *randomTicket = [Ticket ticketUsingQuickPick];
    
    // Spin through our generated ticket to set the picker view to the appropriate values
    int index = 0;
    do {
        NSInteger pick = [randomTicket.picks[index] integerValue];
        [self.pickerView selectRow:pick inComponent:index animated:YES];
        index += 1;
    } while (index < 6);
    
    pickedNumbers = [randomTicket.picks mutableCopy];
    
    // Check if we've picked all of the numbers
    if ([self allNumbersPicked]) {
        self.checkTicketButton.enabled = YES;
        hasPickedAllNumbers = YES;
    } else {
        self.checkTicketButton.enabled = NO;
        hasPickedAllNumbers = NO;
    }
}

- (IBAction)checkTicket:(UIButton *)sender {
    if (hasPickedAllNumbers) {
        [self.delegate returnThePickedNumbers:pickedNumbers];
    }
}

#pragma mark - UIPickerView

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 55;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowString = [NSString stringWithFormat:@"%ld", (long)row];
    NSAttributedString *attributedString;
    if ([pickedNumbers containsObject:[NSNumber numberWithLong:row]]) {
        attributedString = [[NSAttributedString alloc] initWithString:rowString attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        return attributedString;
    }
    attributedString = [[NSAttributedString alloc] initWithString:rowString attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    return attributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger selectedRow = row;
    while ([pickedNumbers containsObject:[NSNumber numberWithInteger:selectedRow]]) {
        selectedRow += 1;
        [self.pickerView selectRow:selectedRow inComponent:component animated:YES];
    }
    
    pickedNumbers[component] = [NSNumber numberWithLong:selectedRow];
    
    // Check if we've picked all of the numbers
    if ([self allNumbersPicked]) {
        self.checkTicketButton.enabled = YES;
        hasPickedAllNumbers = YES;
    } else {
        self.checkTicketButton.enabled = NO;
        hasPickedAllNumbers = NO;
    }
}

@end
