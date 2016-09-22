//
//  MainScreen.h
//  Kindly
//
//  Created by Berry on 22/09/2016.
//  Copyright © 2016 Berry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainScreen : UIViewController
{
    NSMutableArray *aryPlace, *aryFilterPlace;
    NSMutableArray *aryBuddy, *aryFilterBuddy;
    
    UIView *viewMapRoute;
}

//splash
@property (nonatomic, retain) IBOutlet UIView *viewSplash;

//place
@property (nonatomic, retain) IBOutlet UIView *viewPlace;
@property (nonatomic, retain) IBOutlet UITableView *tblPlace;
@property (nonatomic, retain) IBOutlet UISearchBar *srcPlace;

//map
@property (nonatomic, retain) IBOutlet UIView *viewMap;
@property (nonatomic, retain) IBOutlet UIImageView *imgMap;
@property (nonatomic, retain) IBOutlet UIScrollView *scrMap;

//buddy
@property (nonatomic, retain) IBOutlet UIView *viewBuddy;
@property (nonatomic, retain) IBOutlet UITableView *tblBuddy;
@property (nonatomic, retain) IBOutlet UISearchBar *srcBuddy;

@end
