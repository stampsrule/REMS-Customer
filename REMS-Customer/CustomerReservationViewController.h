//
//  CustomerReservationViewController.h
//  REMS-Customer
//
//  Created by Daniel Bell on 2/25/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReservationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
    @property (nonatomic, strong) IBOutlet UITableView *tableView1;
    @property (nonatomic, strong) NSMutableArray *reservationArray;



@end
