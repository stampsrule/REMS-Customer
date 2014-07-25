//
//  CustomerReservationViewController.m
//  REMS-Customer
//
//  Created by Daniel Bell on 2/25/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "CustomerReservationViewController.h"

@interface CustomerReservationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tableNo;
@property (weak, nonatomic) IBOutlet UITextField *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *partySize;
@property (weak, nonatomic) IBOutlet UITextField *notes;
@end

@implementation CustomerReservationViewController
@synthesize tableView1;
@synthesize reservationArray;


- (void)viewDidLoad
{
    [super viewDidLoad];

    // The url to our server endpoint
    NSString *url = @"http://austhaus.com:5000/CPSC471/getReservations.php";
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
    reservationArray=[[NSMutableArray alloc] init];
    [reservationArray addObjectsFromArray:results];
}

- (IBAction)submitData:(UIButton *)sender {
    // The url to our server endpoint
    NSString *url = @"http://austhaus.com:5000/CPSC471/makeReservation.php";
    NSString *date=self.dateLabel.text;
    NSString *notes=self.notes.text;
    NSString *parysize=self.partySize.text;
    NSString *tableno=self.tableNo.text;
    NSString *card=@"3";
    NSString *postpart1=[NSString stringWithFormat:@"datetime=%@", date];
    NSString *postpart2=[postpart1 stringByAppendingString:[NSString stringWithFormat:@"&notes=%@",notes]];
    NSString *postpart3=[postpart2 stringByAppendingString:[NSString stringWithFormat:@"&table=%@",tableno]];
    NSString *postpart4=[postpart3 stringByAppendingString:[NSString stringWithFormat:@"&card=%@", card]];
    NSString *postpart5=[postpart4 stringByAppendingString:[NSString stringWithFormat:@"&partysize=%@",parysize]];
    NSString *post =postpart5;
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.reservationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    NSDictionary *myreservations=[[NSDictionary alloc] initWithDictionary:[reservationArray objectAtIndex:indexPath.row]];
    cell.textLabel.text =[myreservations objectForKey:@"datetime"];
    //cell.detailTextLabel.text=[myreservations objectForKey:@"notes"];
    
    return cell;
}



@end
