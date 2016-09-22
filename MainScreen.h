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
    //gesture
    CGPoint startLocation;
    int intAtPage;
    
    NSMutableArray *aryKindFeed, *aryEvent, *aryReward, *aryProfile;
    
    UIRefreshControl *rfcKindFeed, *rfcEvent, *rfcReward;
}

//splash
@property (nonatomic, retain) IBOutlet UIView *viewSplash;

//top tab
@property (nonatomic, retain) IBOutlet UIView *viewTab;
@property (nonatomic, retain) IBOutlet UIButton *btnKindFeed, *btnEvent, *btnReward;
@property (nonatomic, retain) UILabel *lblTabline;

//kindfeed
@property (nonatomic, retain) IBOutlet UIView *viewKindFeed;
@property (nonatomic, retain) IBOutlet UITableView *tblKindFeed;

//event
@property (nonatomic, retain) IBOutlet UIView *viewEvent;
@property (nonatomic, retain) IBOutlet UITableView *tblEvent;

//reward
@property (nonatomic, retain) IBOutlet UIView *viewReward;
@property (nonatomic, retain) IBOutlet UITableView *tblReward;


@end
