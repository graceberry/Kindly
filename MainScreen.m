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

@synthesize lblPlaceTitle, lblPlaceTitle2, lblPlaceTitle3;

//map
@synthesize viewMap;
@synthesize scrMap;

@synthesize viewMapList;
@synthesize tblMapList;

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
    
    [viewMapList setFrame:CGRectMake(0, 0, viewMapList.frame.size.width, viewMapList.frame.size.height)];
    [viewMapList setHidden:YES];
    [self.view addSubview:viewMapList];
    
    [viewBuddy setFrame:CGRectMake(0, 0, viewBuddy.frame.size.width, viewBuddy.frame.size.height)];
    [viewBuddy setHidden:YES];
    [self.view addSubview:viewBuddy];
    
    [viewSplash setFrame:CGRectMake(0, 0, viewSplash.frame.size.width, viewSplash.frame.size.height)];
    [viewSplash setHidden:YES];
    [self.view addSubview:viewSplash];
    
    //splash
    //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(goMain) userInfo:nil repeats:NO];
    
    //aryPlace = [[NSMutableArray alloc]initWithObjects:@"TEST 1",@"TEST 2",@"TEST 3", nil];
    aryFilterPlace = [[NSMutableArray alloc] init];
    [self displayPlaceData];
    
    aryBuddy = [[NSMutableArray alloc]initWithObjects:@"BUDDY 1",@"BUDDY 2",@"BUDDY 3", nil];
    aryFilterBuddy = [[NSMutableArray alloc] init];
    
    aryMapList = [[NSMutableArray alloc]initWithObjects:@"BUDDY 1",@"BUDDY 2",@"BUDDY 3", nil];
    aryFilterMapList = [[NSMutableArray alloc] init];
    
    tmrAnimation = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animatePoint) userInfo:nil repeats:YES];
}

-(void) displayPlaceData
{
    NSDictionary *dict1 = @{
                            @"title": @"Big Bad Wolf",
                            @"image": @"place1.jpg",
                            @"period": @"21 - 25 January 2016"
                            };
    
    NSDictionary *dict2 = @{
                            @"title": @"Comic Con",
                            @"image": @"place2.jpg",
                            @"period": @"21 - 25 January 2016"
                            };
    
    NSDictionary *dict3 = @{
                            @"title": @"Comic Fiesta",
                            @"image": @"place3.jpg",
                            @"period": @"21 - 25 January 2016"
                            };
    
    aryPlace = [NSMutableArray arrayWithObjects: dict1, dict2, dict3, nil];
    
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
    }else if (tableView==tblMapList)
    {
        return [aryFilterMapList count];
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
        [cell setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
        
        UILabel *lblBG = [[UILabel alloc] init];
        [lblBG setFrame:CGRectMake(10, 10, 300, 100)];
        [lblBG setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:lblBG];
        
        UIImageView *imgPlace = [[UIImageView alloc] init];
        [imgPlace setFrame:CGRectMake(10, 10, 110, 100)];
        [imgPlace setBackgroundColor:[UIColor redColor]];
        [imgPlace setImage:[UIImage imageNamed:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"image"]]];
        [imgPlace setContentMode:UIViewContentModeScaleAspectFill];
        [imgPlace setClipsToBounds:YES];
        [cell addSubview:imgPlace];
        
        UITextView *txtPlace = [[UITextView alloc] init];
        [txtPlace setFrame:CGRectMake(125, 20, 180, 45)];
        [txtPlace setText:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [txtPlace setFont:[UIFont boldSystemFontOfSize:20]];
        [txtPlace setUserInteractionEnabled:NO];
        [cell addSubview:txtPlace];
        
        UILabel *lblDate = [[UILabel alloc] init];
        [lblDate setFrame:CGRectMake(130, 78-10, 180, 20)];
        [lblDate setText:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"period"]];
        [lblDate setFont:[UIFont systemFontOfSize:14]];
        [cell addSubview:lblDate];
        
        UILabel *lblSeparator = [[UILabel alloc] init];
        [lblSeparator setFrame:CGRectMake(15, 110, 295, 2)];
        [lblSeparator setBackgroundColor:[UIColor darkGrayColor]];
        [lblSeparator setAlpha:0.6];
        [cell addSubview:lblSeparator];
        
    }else if (tableView==tblBuddy)
    {
        UIImageView *imgPic = [[UIImageView alloc] init];
        [imgPic setFrame:CGRectMake(15, 10, 70, 70)];
        [imgPic setBackgroundColor:[UIColor redColor]];
        [imgPic setImage:[UIImage imageNamed:@""]];
        [imgPic setContentMode:UIViewContentModeScaleAspectFill];
        [imgPic.layer setCornerRadius:35];
        [imgPic.layer setMasksToBounds:YES];
        [cell addSubview:imgPic];
        
        UILabel *lblName = [[UILabel alloc] init];
        [lblName setFrame:CGRectMake(105, 20, 200, 20)];
        [lblName setText:[aryFilterBuddy objectAtIndex:indexPath.row]];
        [lblName setFont:[UIFont boldSystemFontOfSize:17]];
        [cell addSubview:lblName];
        
        UILabel *lblDes = [[UILabel alloc] init];
        [lblDes setFrame:CGRectMake(105, 47, 200, 20)];
        [lblDes setText:[aryFilterBuddy objectAtIndex:indexPath.row]];
        [lblDes setFont:[UIFont systemFontOfSize:14]];
        [lblDes setTextColor:[UIColor lightGrayColor]];
        [cell addSubview:lblDes];
        
        UILabel *lblSeparator = [[UILabel alloc] init];
        [lblSeparator setFrame:CGRectMake(95, 84, tblBuddy.frame.size.width-110, 1)];
        [lblSeparator setBackgroundColor:[UIColor lightGrayColor]];
        [cell addSubview:lblSeparator];
        
    }else if (tableView==tblMapList)
    {
        UILabel *lblName = [[UILabel alloc] init];
        [lblName setFrame:CGRectMake(25, 20, 270, 20)];
        [lblName setText:[aryFilterMapList objectAtIndex:indexPath.row]];
        [lblName setFont:[UIFont boldSystemFontOfSize:17]];
        [cell addSubview:lblName];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView==tblPlace)
    {
        [self.view endEditing:YES];
        [lblPlaceTitle setText:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [lblPlaceTitle2 setText:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [lblPlaceTitle3 setText:[[aryFilterPlace objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [viewMapList setHidden:NO];
        
        [self filterMaplist:@""];
    }else if (tableView==tblBuddy)
    {
        
    }else if (tableView==tblMapList)
    {
        [self.view endEditing:YES];
        [self btnMapView:nil];
    }
}

-(IBAction)btnBackMap:(id)sender
{
    [viewMap setHidden:YES];
}

-(IBAction)btnBackMapList:(id)sender
{
    [viewMapList setHidden:YES];
}

-(IBAction)btnMapView:(id)sender
{
    [viewMapList setHidden:YES];
    [viewMap setHidden:NO];
    [self setUpMapRouteContent];
}

-(IBAction)btnMapList:(id)sender
{
    [viewMap setHidden:YES];
    [viewMapList setHidden:NO];
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

-(IBAction)btnBackMain:(id)sender
{
    [viewBuddy setHidden:YES];
    [viewMapList setHidden:YES];
    [viewMap setHidden:YES];
}

-(IBAction)btnPath1:(id)sender
{
    [self setUpMapRouteContent];
    [self createPathStartPoint:@"A"];
    [self createBeaconAtPoint:@"A"];
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

- (void) animatePoint
{
    if(++intAniCount>1000000)
        intAniCount=0;
    
    int intLoop = 5-(((5-(intAniCount%10))*(5-(intAniCount%10)))/2);
    [imgPoint setFrame:CGRectMake(0, 0, 22+intLoop+40-20, 22+intLoop+40-20)];
    [imgPoint setCenter:CGPointMake(viewPointLocation.frame.size.width/2, viewPointLocation.frame.size.height/2)];
}

- (void) Apath2
{
    [UIView beginAnimations:@"swipe" context:NULL];
    [UIView setAnimationDuration:1.0f];
    [viewPointLocation setFrame:CGRectMake(145-50, 550-50, 100, 100)];
    [UIView commitAnimations];
}

- (void) Apath3
{
    [UIView beginAnimations:@"swipe" context:NULL];
    [UIView setAnimationDuration:3.0f];
    [viewPointLocation setFrame:CGRectMake(334-50, 550-50, 100, 100)];
    [UIView commitAnimations];
}

- (void) Apath4
{
    [UIView beginAnimations:@"swipe" context:NULL];
    [UIView setAnimationDuration:0.2f];
    [viewPointLocation setFrame:CGRectMake(334-50, 521-50, 100, 100)];
    [UIView commitAnimations];
}

- (void) Bpath2
{
    [UIView beginAnimations:@"swipe" context:NULL];
    [UIView setAnimationDuration:2.0f];
    [viewPointLocation setFrame:CGRectMake(445-50, 247-50, 100, 100)];
    [UIView commitAnimations];
}

- (void) Bpath3
{
    [UIView beginAnimations:@"swipe" context:NULL];
    [UIView setAnimationDuration:3.0f];
    [viewPointLocation setFrame:CGRectMake(445-50, 458-50, 100, 100)];
    [UIView commitAnimations];
}

- (void) createBeaconAtPoint:(NSString *) strPoint
{
    if (viewPointLocation !=nil)
    {
        [viewPointLocation removeFromSuperview];
    }
    
    if ([strPoint isEqualToString:@"A"])
    {
        viewPointLocation = [[UIView alloc] initWithFrame:CGRectMake(119-50, 438-50, 100, 100)];
        
        [UIView beginAnimations:@"swipe" context:NULL];
        [UIView setAnimationDuration:0.2f];
        [viewPointLocation setFrame:CGRectMake(145-50, 438-50, 100, 100)];
        [UIView commitAnimations];
        
        [self performSelector:@selector(Apath2) withObject:nil afterDelay:0.4];
        [self performSelector:@selector(Apath3) withObject:nil afterDelay:1.6];
        [self performSelector:@selector(Apath4) withObject:nil afterDelay:4.8];
        
    }else if ([strPoint isEqualToString:@"B"])
    {
        viewPointLocation = [[UIView alloc] initWithFrame:CGRectMake(337-50, 216-50, 100, 100)];
        
        [UIView beginAnimations:@"swipe" context:NULL];
        [UIView setAnimationDuration:1.0f];
        [viewPointLocation setFrame:CGRectMake(337-50, 247-50, 100, 100)];
        [UIView commitAnimations];
        
        [self performSelector:@selector(Bpath2) withObject:nil afterDelay:1.2];
        [self performSelector:@selector(Bpath3) withObject:nil afterDelay:3.4];
    }
    [viewMapRoute addSubview:viewPointLocation];
    
    UIImageView *imgArea = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationtracker_area.png"]];
    [imgArea setFrame:CGRectMake(0, 0, 100, 100)];
    [viewPointLocation addSubview:imgArea];
    
    UIImageView *imgWhite = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationtracker_white.png"]];
    [imgWhite setFrame:CGRectMake(50-12, 50-12, 25+45-25, 25+40-20)];
    [imgWhite setCenter:CGPointMake(viewPointLocation.frame.size.width/2, viewPointLocation.frame.size.height/2)];
    [viewPointLocation addSubview:imgWhite];
    
    imgPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationtracker_blue.png"]];
    [imgPoint setFrame:CGRectMake(50-12, 50-12, 25+40-20, 25+40-20)];
    [imgPoint setCenter:CGPointMake(viewPointLocation.frame.size.width/2, viewPointLocation.frame.size.height/2)];
    [viewPointLocation addSubview:imgPoint];
}

-(void) filterPlace:(NSString *)strText
{
    [aryFilterPlace removeAllObjects];
    for (int x=0; x<[aryPlace count]; x++)
    {
        //compare substring
        NSString *strPlace = [[aryPlace objectAtIndex:x] objectForKey:@"title"];
        
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

-(void) filterMaplist:(NSString *)strText
{
    [aryFilterMapList removeAllObjects];
    for (int x=0; x<[aryMapList count]; x++)
    {
        //compare substring
        NSString *strPlace = [aryMapList objectAtIndex:x];
        
        if ([[strPlace uppercaseString] rangeOfString:[strText uppercaseString]].location != NSNotFound || [strText isEqualToString:@""])
        {
            [aryFilterMapList addObject:[aryMapList objectAtIndex:x]];
        }
    }
    [tblMapList reloadData];
    NSLog(@"tblMapList::%@::",aryFilterMapList);
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
