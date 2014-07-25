//
//  CustomerViewController.m
//  REMS-Customer
//
//  Created by Daniel Bell on 2/25/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation CustomerViewController
@synthesize mybalance;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *url = @"http://austhaus.com:5000/CPSC471/getBalance.php";
    NSString *post = @"card=3";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSArray *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    mybalance=[[[NSDictionary alloc] initWithDictionary:results[0]] objectForKey:@"balance"];
    self.balanceLabel.text=mybalance;
}
- (IBAction)reloadBalance:(UIButton *)sender {
    NSString *url = @"http://austhaus.com:5000/CPSC471/getBalance.php";
    NSString *post = @"card=3";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSArray *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    mybalance=[[[NSDictionary alloc] initWithDictionary:results[0]] objectForKey:@"balance"];
    self.balanceLabel.text=mybalance;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
