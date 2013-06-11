//
//  SPoTTVC.h
//  SPoT
//
//  Created by Chris on 6/11/13.
//  Copyright (c) 2013 Chris Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"

@interface SPoTTVC : UITableViewController

- (NSMutableDictionary *) tagsAndCount;
-(NSArray *)tags;

-(NSMutableArray *)photosWithTag:(NSString *)tag;

@end
