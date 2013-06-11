//
//  SPoTViewController.m
//  SPoT
//
//  Created by Chris on 6/11/13.
//  Copyright (c) 2013 Chris Chapman. All rights reserved.
//

#import "SPoTViewController.h"
#import "FlickrFetcher.h"

@interface SPoTViewController ()

@end

@implementation SPoTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *stanfordPhotos = [FlickrFetcher stanfordPhotos];
    
    NSLog(@"%@",stanfordPhotos[1]);
}

@end
