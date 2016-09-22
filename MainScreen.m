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
    }else if (tableView==tblBuddy)
    {
        
    }
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
