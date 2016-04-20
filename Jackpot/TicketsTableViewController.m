//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Donny Davis on 4/20/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "Ticket.h"

@interface TicketsTableViewController () {
    
    NSMutableArray *tickets;
    
}

- (IBAction)createTicket:(id)sender;
- (IBAction)checkWinners:(id)sender;

@end

@implementation TicketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    tickets = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([aTicket.payout containsString:@"sorry please play again"]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    cell.detailTextLabel.text = aTicket.payout;
    
    return cell;
}

#pragma mark - Bar button item actions

- (IBAction)createTicket:(id)sender {
    Ticket *aTicket = [Ticket ticketUsingQuickPick];
    [tickets addObject:aTicket];
    
    [self.tableView reloadData];
}

- (IBAction)checkWinners:(id)sender {
    // Create a winning ticket
    Ticket *winningTicket = [Ticket ticketUsingQuickPick];
    
    for (Ticket *ourTicket in tickets) {
        [ourTicket compareWithTicket:winningTicket];
    }
    
    [self.tableView reloadData];
}

@end
