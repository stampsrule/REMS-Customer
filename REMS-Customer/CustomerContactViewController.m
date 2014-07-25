//
//  CustomerContactViewController.m
//  REMS-Customer
//
//  Created by Daniel Bell on 2014-04-07.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "CustomerContactViewController.h"

@interface CustomerContactViewController ()

@end

@implementation CustomerContactViewController

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
- (IBAction)callPhone:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18002633394"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
