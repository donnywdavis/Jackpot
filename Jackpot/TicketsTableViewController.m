//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Donny Davis on 4/20/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "WinningTicketViewController.h"
#import "Ticket.h"

@interface TicketsTableViewController () <WinningTicketViewControllerDelegate> {
    
    NSMutableArray *tickets;
    int totalWinnings, totalSpent;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *wonSpentLabel;

- (IBAction)createTicket:(id)sender;
- (void)checkWinners:(NSArray *)pickedNumbers;

@end

@implementation TicketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tickets = [[NSMutableArray alloc] init];
    totalWinnings = 0;
    totalSpent = 0;
    [self.navigationController setToolbarHidden:NO];
    self.wonSpentLabel.title = @"Won: $0 Spent: $0";
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnThePickedNumbers:(NSArray *)pickedNumbers {
    [self checkWinners:pickedNumbers];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LottoTicket" forIndexPath:indexPath];
    
    // Configure the cell...
    Ticket *aTicket = tickets[indexPath.row];
    
    cell.textLabel.text = [aTicket description];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%d", aTicket.payout];
    if (aTicket.winner) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WinnerWinnerChickenDinner"]) {
        WinningTicketViewController *wtvc = (WinningTicketViewController *)segue.destinationViewController;
        wtvc.delegate = self;
    }
}

- (IBAction)returnToTickets:(UIStoryboardSegue *)segue {
    
}

#pragma mark - Bar button item actions

- (IBAction)createTicket:(id)sender {
    Ticket *aTicket = [Ticket ticketUsingQuickPick];
    [tickets addObject:aTicket];
    
    totalSpent += aTicket.ticketPrice;
    self.wonSpentLabel.title = [NSString stringWithFormat:@"Won: $%d Spent: $%d", totalWinnings, totalSpent];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(tickets.count - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)checkWinners:(NSArray *)pickedNumbers {
    // Create a winning ticket
    Ticket *winningTicket = [Ticket ticketUsingArray:pickedNumbers];
    
    totalWinnings = 0;
    for (Ticket *ourTicket in tickets) {
        [ourTicket compareWithTicket:winningTicket];
        totalWinnings += ourTicket.payout;
    }
    
    // Let's sort our array to show all of our winnings at the top
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"payout" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    tickets = [[tickets sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    
    // Let's color the numbers that we matched correctly
    
    
    self.wonSpentLabel.title = [NSString stringWithFormat:@"Won: $%d Spent: $%d", totalWinnings, totalSpent];
    [self.tableView reloadData];
}

@end
