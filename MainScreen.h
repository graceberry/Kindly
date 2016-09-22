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
    NSMutableArray *aryPlace, *aryFilterPlace, *aryMapList, *aryFilterMapList;
    NSMutableArray *aryBuddy, *aryFilterBuddy;
    
    UIView *viewMapRoute, *viewPointLocation;
    int intAniCount;
    UIImageView *imgMap;
    
    NSTimer *tmrAnimation;
    UIImageView *imgPoint;
}

//splash
@property (nonatomic, retain) IBOutlet UIView *viewSplash;

//place
@property (nonatomic, retain) IBOutlet UIView *viewPlace;
@property (nonatomic, retain) IBOutlet UITableView *tblPlace;
@property (nonatomic, retain) IBOutlet UISearchBar *srcPlace;

@property (nonatomic, retain) IBOutlet UILabel *lblPlaceTitle, *lblPlaceTitle2, *lblPlaceTitle3;

//map
@property (nonatomic, retain) IBOutlet UIView *viewMap;
@property (nonatomic, retain) IBOutlet UIScrollView *scrMap;

@property (nonatomic, retain) IBOutlet UIView *viewMapList;
@property (nonatomic, retain) IBOutlet UITableView *tblMapList;
@property (nonatomic, retain) IBOutlet UISearchBar *srcMapList;

//buddy
@property (nonatomic, retain) IBOutlet UIView *viewBuddy;
@property (nonatomic, retain) IBOutlet UITableView *tblBuddy;
@property (nonatomic, retain) IBOutlet UISearchBar *srcBuddy;

@end
