//
//  MainScreen.m
//  Kindly
//
//  Created by Berry on 22/09/2016.
//  Copyright © 2016 Berry. All rights reserved.
//

#import "MainScreen.h"

@interface MainScreen ()

@end

@implementation MainScreen

@synthesize viewSplash;

//place
@synthesize viewPlace;
@synthesize tblPlace;
@synthesize srcPlace;

//map
@synthesize viewMap;
@synthesize imgMap;
@synthesize scrMap;

//buddy
@synthesize viewBuddy;
@synthesize tblBuddy;
@synthesize srcBuddy;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [viewPlace setFrame:CGRectMake(0, 0, viewPlace.frame.size.width, viewPlace.frame.size.height)];
    [viewPlace setHidden:NO];
    [self.view addSubview:viewPlace];
    
    [viewMap setFrame:CGRectMake(0, 0, viewMap.frame.size.width, viewMap.frame.size.height)];
    [viewMap setHidden:YES];
    [self.view addSubview:viewMap];
    
    [viewBuddy setFrame:CGRectMake(0, 0, viewBuddy.frame.size.width, viewBuddy.frame.size.height)];
    [viewBuddy setHidden:YES];
    [self.view addSubview:viewBuddy];
    
    [viewSplash setFrame:CGRectMake(0, 0, viewSplash.frame.size.width, viewSplash.frame.size.height)];
    [viewSplash setHidden:YES];
    [self.view addSubview:viewSplash];
    
    //splash
    //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(goMain) userInfo:nil repeats:NO];
    
    aryPlace = [[NSMutableArray alloc]initWithObjects:@"TEST 1",@"TEST 2",@"TEST 3", nil];
    aryFilterPlace = [[NSMutableArray alloc] init];
    
    aryBuddy = [[NSMutableArray alloc]initWithObjects:@"BUDDY 1",@"BUDDY 2",@"BUDDY 3", nil];
    aryFilterBuddy = [[NSMutableArray alloc] init];
    
    [self filterPlace:@""];
}

- (void)goMain
{
    [viewSplash setHidden:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tblPlace)
    {
        return [aryFilterPlace count];
    }else if (tableView==tblBuddy)
    {
        return [aryFilterBuddy count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    else
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Event Table
    if (tableView==tblPlace)
    {
        UILabel *lblCard = [[UILabel alloc] init];
        [lblCard setFrame:CGRectMake(20, 10, 300, 20)];
        [lblCard setText:[aryFilterPlace objectAtIndex:indexPath.row]];
        [cell addSubview:lblCard];
        
        UILabel *lblSeparator = [[UILabel alloc] init];
        [lblSeparator setFrame:CGRectMake(15, 39, tblPlace.frame.size.width-30, 1)];
        [lblSeparator setBackgroundColor:[UIColor darkGrayColor]];
        [cell addSubview:lblSeparator];
        
    }else if (tableView==tblBuddy)
    {
        UILabel *lblCard = [[UILabel alloc] init];
        [lblCard setFrame:CGRectMake(20, 10, 300, 20)];
        [lblCard setText:[aryFilterBuddy objectAtIndex:indexPath.row]];
        [cell addSubview:lblCard];
        
        UILabel *lblSeparator = [[UILabel alloc] init];
        [lblSeparator setFrame:CGRectMake(15, 39, tblBuddy.frame.size.width-30, 1)];
        [lblSeparator setBackgroundColor:[UIColor darkGrayColor]];
        [cell addSubview:lblSeparator];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView==tblPlace)
    {
        [viewMap setHidden:NO];
        [self setUpMapRouteContent];
    }else if (tableView==tblBuddy)
    {
        
    }
}

-(void) setUpMapRouteContent
{
    if(viewMapRoute!=nil)
    {
        [viewMapRoute removeFromSuperview];
    }
    
    viewMapRoute = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrMap.frame.size.width, scrMap.frame.size.height)];
    [viewMapRoute setBackgroundColor:[UIColor redColor]];
    [viewMapRoute setAlpha:0.5];
    [scrMap addSubview:viewMapRoute];
}

-(IBAction)btnBuddyList:(id)sender
{
    [viewBuddy setHidden:NO];
    [self filterBuddy:@""];
}

-(IBAction)btnBackBuddyList:(id)sender
{
    [viewBuddy setHidden:YES];
}

-(IBAction)btnPath1:(id)sender
{
    [self createPathStartPoint:CGPointMake(62, 220) withEndPoint:CGPointMake(62, 305) withColor:[UIColor blueColor] withStation:3];
}

//Draw Path Way
- (void)createPathStartPoint:(CGPoint)pointStartLocation withEndPoint:(CGPoint)pointEndLocation withColor:(UIColor *)pathColor withStation:(int)intStation
{
    //Draw Path
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    [trackPath moveToPoint:CGPointMake(pointStartLocation.x, pointStartLocation.y)];
    [trackPath addLineToPoint:CGPointMake(pointEndLocation.x, pointEndLocation.y)];
    
    CAShapeLayer *centerline = [CAShapeLayer layer];
    [centerline setPath:trackPath.CGPath];
    [centerline setStrokeColor:pathColor.CGColor];
    [centerline setFillColor:[[UIColor clearColor] CGColor]];
    [centerline setLineWidth:10];
    [viewMapRoute.layer addSublayer:centerline];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [animation setDuration:5];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setAutoreverses:NO];
    [animation setFromValue:[NSNumber numberWithFloat:0]];
    [animation setToValue:[NSNumber numberWithFloat:1]];
    [centerline addAnimation:animation forKey:@"animatePath"];
    
}

/*-(IBAction)btnRemove:(id)sender
{
    if(viewMapRoute!=nil)
    {
        [viewMapRoute removeFromSuperview];
    }
    
    viewMapRoute = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    [viewMapRoute setBackgroundColor:[UIColor clearColor]];
    [viewMapRoute setAlpha:0.5];
    [viewPassengerAnnouncement addSubview:viewMapRoute];
    
    [viewPassengerAnnouncement bringSubviewToFront:btnStation1];
    [viewPassengerAnnouncement bringSubviewToFront:btnStation2];
    [viewPassengerAnnouncement bringSubviewToFront:btnStation3];
    [viewPassengerAnnouncement bringSubviewToFront:btnStation4];
    
    [btnStation1 setImage:[UIImage imageNamed:@"train_icon_select.png"] forState:UIControlStateNormal];
    [btnStation2 setImage:[UIImage imageNamed:@"train_icon.png"] forState:UIControlStateNormal];
    [btnStation3 setImage:[UIImage imageNamed:@"train_icon.png"] forState:UIControlStateNormal];
    [btnStation4 setImage:[UIImage imageNamed:@"train_icon.png"] forState:UIControlStateNormal];
    
    [imgStation1 setImage:[UIImage imageNamed:@"station_name_select.png"]];
    [imgStation2 setImage:[UIImage imageNamed:@"station_name.png"]];
    [imgStation3 setImage:[UIImage imageNamed:@"station_name.png"]];
    [imgStation4 setImage:[UIImage imageNamed:@"station_name.png"]];
    [imgAd1 setImage:[UIImage imageNamed:@"ad1.png"]];
}*/

-(void) filterPlace:(NSString *)strText
{
    [aryFilterPlace removeAllObjects];
    for (int x=0; x<[aryPlace count]; x++)
    {
        //compare substring
        NSString *strPlace = [aryPlace objectAtIndex:x];
        
        if ([[strPlace uppercaseString] rangeOfString:[strText uppercaseString]].location != NSNotFound || [strText isEqualToString:@""])
        {
            [aryFilterPlace addObject:[aryPlace objectAtIndex:x]];
        }
    }
    [tblPlace reloadData];
    NSLog(@"aryFilterPlace::%@::",aryFilterPlace);
}

-(void) filterBuddy:(NSString *)strText
{
    [aryFilterBuddy removeAllObjects];
    for (int x=0; x<[aryBuddy count]; x++)
    {
        //compare substring
        NSString *strPlace = [aryBuddy objectAtIndex:x];
        
        if ([[strPlace uppercaseString] rangeOfString:[strText uppercaseString]].location != NSNotFound || [strText isEqualToString:@""])
        {
            [aryFilterBuddy addObject:[aryBuddy objectAtIndex:x]];
        }
    }
    [tblBuddy reloadData];
    NSLog(@"aryFilterBuddy::%@::",aryFilterBuddy);
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    if(srcPlace==theSearchBar)
    {
        [self filterPlace:searchText];
    }else if(srcBuddy==theSearchBar)
    {
        [self filterBuddy:searchText];
    }
}

// When the search bar starts to be edited
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar becomeFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
}

// When it ended editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

// When the search button is clicked
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

//When you cancel, it sets the cancel button to leave with animation
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

//Dismiss when scrolled
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
