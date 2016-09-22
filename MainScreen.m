//
//  MainScreen.m
//  Kindly
//
//  Created by Berry on 22/09/2016.
//  Copyright © 2016 Berry. All rights reserved.
//

#import "MainScreen.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5
#define degreesToRadian(x) (M_PI * (x) / 180.0)

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
    
    viewMapRoute = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 800)];
    [viewMapRoute setBackgroundColor:[UIColor clearColor]];
    [viewMapRoute setAlpha:1];
    [scrMap addSubview:viewMapRoute];
    
    imgMap = [[UIImageView alloc] init];
    [imgMap setFrame:CGRectMake(0, 0, viewMapRoute.frame.size.width, viewMapRoute.frame.size.height)];
    [imgMap setImage:[UIImage imageNamed:@"event_map_1_resize.jpg"]];
    [viewMapRoute addSubview:imgMap];
    
    // set the tag for the image view
    [viewMapRoute setTag:ZOOM_VIEW_TAG];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [scrMap frame].size.width  / [viewMapRoute frame].size.width;
    [scrMap setMinimumZoomScale:minimumScale];
    [scrMap setZoomScale:0.156250];
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
    [self createPathStartPoint:@"B"];
}

//Draw Path Way
- (void)createPathStartPoint:(NSString *)strPath
{
    //Draw Path
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    
    if ([strPath isEqualToString:@"A"])
    {
        [trackPath moveToPoint:CGPointMake(119, 438)];
        [trackPath addLineToPoint:CGPointMake(145, 438)];
        [trackPath addLineToPoint:CGPointMake(145, 550)];
        [trackPath addLineToPoint:CGPointMake(334, 550)];
        [trackPath addLineToPoint:CGPointMake(334, 521)];
    }else if ([strPath isEqualToString:@"B"])
    {
        [trackPath moveToPoint:CGPointMake(337, 216)];
        [trackPath addLineToPoint:CGPointMake(337, 247)];
        [trackPath addLineToPoint:CGPointMake(445, 247)];
        [trackPath addLineToPoint:CGPointMake(445, 458)];
    }
    
    CAShapeLayer *centerline = [CAShapeLayer layer];
    [centerline setPath:trackPath.CGPath];
    [centerline setStrokeColor:[UIColor redColor].CGColor];
    [centerline setFillColor:[[UIColor clearColor] CGColor]];
    [centerline setLineWidth:10];
    centerline.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:10], nil];
    [viewMapRoute.layer addSublayer:centerline];
    
    CABasicAnimation *dashAnimation;
    dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
    [dashAnimation setFromValue:[NSNumber numberWithFloat:30.0f]];
    [dashAnimation setToValue:[NSNumber numberWithFloat:0.0f]];
    [dashAnimation setDuration:0.75f];
    [dashAnimation setRepeatCount:HUGE_VAL];
    [centerline addAnimation:dashAnimation forKey:@"linePhase"];
    
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"here");
    return [viewMapRoute viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark Utility methods
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    
    CGRect zoomRect;
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [scrMap frame].size.height / scale;
    zoomRect.size.width  = [scrMap frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
