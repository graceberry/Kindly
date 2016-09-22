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

//top tab
@synthesize viewTab;
@synthesize btnKindFeed, btnEvent, btnReward;
@synthesize lblTabline;

//kindfeed
@synthesize viewKindFeed;
@synthesize tblKindFeed;

//event
@synthesize viewEvent;
@synthesize tblEvent;

//reward
@synthesize viewReward;
@synthesize tblReward;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [viewKindFeed setFrame:CGRectMake(0, 0, viewKindFeed.frame.size.width, viewKindFeed.frame.size.height)];
    [viewKindFeed setHidden:NO];
    [self.view addSubview:viewKindFeed];
    
    [viewEvent setFrame:CGRectMake(viewEvent.frame.size.width, 0, viewEvent.frame.size.width, viewEvent.frame.size.height)];
    [viewEvent setHidden:NO];
    [self.view addSubview:viewEvent];
    
    [viewReward setFrame:CGRectMake(viewEvent.frame.size.width*2, 0, viewReward.frame.size.width, viewReward.frame.size.height)];
    [viewReward setHidden:NO];
    [self.view addSubview:viewReward];
    
    [viewTab setFrame:CGRectMake(0, 0, viewTab.frame.size.width, viewTab.frame.size.height)];
    [viewTab setHidden:NO];
    [self.view addSubview:viewTab];
    
    lblTabline = [[UILabel alloc] init];
    [lblTabline setFrame:CGRectMake(8, 114, 92, 2)];
    [lblTabline setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    [lblTabline setHidden:NO];
    [self.view addSubview:lblTabline];
    
    [viewSplash setFrame:CGRectMake(0, 0, viewSplash.frame.size.width, viewSplash.frame.size.height)];
    [viewSplash setHidden:YES];
    [self.view addSubview:viewSplash];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    //defaul UI
    intAtPage=1;
    
    [btnKindFeed.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [btnKindFeed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btnEvent.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnEvent setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
    
    [btnReward.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnReward setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
    
    //splash
    //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(goMain) userInfo:nil repeats:NO];
}

- (void)goMain
{
    [viewSplash setHidden:YES];
}

//use pan gesture so that view can follow finger
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        startLocation = [panGestureRecognizer locationInView:self.view];
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint changingLocation = [panGestureRecognizer locationInView:self.view];
        CGFloat distanceX = changingLocation.x - startLocation.x;
        
        if (distanceX > 5.0f)
        {
            //NSLog(@"duringleft %f:", distanceX);
            
            if (intAtPage==2)
            {
                [viewKindFeed setFrame:CGRectMake(-320 + distanceX, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(0 + distanceX, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(320 + distanceX, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(115 + (- distanceX/3), 114, 92, 2)];
            }else if (intAtPage==3)
            {
                [viewKindFeed setFrame:CGRectMake(-640 + distanceX, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(-320 + distanceX, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(0 + distanceX, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(222 + (- distanceX/3), 114, 92, 2)];
            }
        }else if (distanceX < -5.0f)
        {
            //NSLog(@"duringright %f:", distanceX);
            if (intAtPage==1)
            {
                [viewKindFeed setFrame:CGRectMake(0 + distanceX, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(320 + distanceX, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(640 + distanceX, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(8 + (- distanceX/3), 114, 92, 2)];
            }else if (intAtPage==2)
            {
                [viewKindFeed setFrame:CGRectMake(-320 + distanceX, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(0 + distanceX, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(320 + distanceX, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(115 + (- distanceX/3), 114, 92, 2)];
            }
        }
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint stopLocation = [panGestureRecognizer locationInView:self.view];
        CGFloat distanceX = stopLocation.x - startLocation.x;
        //NSLog(@"Distance: %f::", dx);
        
        if (distanceX > 5.0f)
        {
            if (intAtPage==2)
            {
                intAtPage=1;
                
                [UIView beginAnimations:@"swipe" context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:0.7f];
                
                [viewKindFeed setFrame:CGRectMake(0, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(320, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(640, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(8, 114, 92, 2)];
                [UIView commitAnimations];
                
                [btnKindFeed.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [btnKindFeed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                
                [btnEvent.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnEvent setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
                [btnReward.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnReward setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
            }else if (intAtPage==3)
            {
                intAtPage=2;
                
                [UIView beginAnimations:@"swipe" context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:0.7f];
                
                [viewKindFeed setFrame:CGRectMake(-320, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(0, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(320, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(115, 114, 92, 2)];
                [UIView commitAnimations];
                
                [btnKindFeed.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnKindFeed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
                [btnEvent.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [btnEvent setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                
                [btnReward.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnReward setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
            }
        }else if (distanceX < -5.0f)
        {
            if (intAtPage==1)
            {
                intAtPage=2;
                
                [UIView beginAnimations:@"swipe" context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:0.7f];
                
                [viewKindFeed setFrame:CGRectMake(-320, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(0, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(320, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(115, 114, 92, 2)];
                [UIView commitAnimations];
                
                [btnKindFeed.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnKindFeed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
                [btnEvent.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [btnEvent setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
                
                [btnReward.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnReward setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
            }else if (intAtPage==2)
            {
                intAtPage=3;
                
                [UIView beginAnimations:@"swipe" context:NULL];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:0.7f];
                
                [viewKindFeed setFrame:CGRectMake(-640, 0, 320, 568)];
                [viewEvent setFrame:CGRectMake(-320, 0, 320, 568)];
                [viewReward setFrame:CGRectMake(0, 0, 320, 568)];
                
                [lblTabline setFrame:CGRectMake(222, 114, 92, 2)];
                [UIView commitAnimations];
                
                [btnKindFeed.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnKindFeed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
                [btnEvent.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btnEvent setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] forState:UIControlStateNormal];
                
                [btnReward.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [btnReward setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
