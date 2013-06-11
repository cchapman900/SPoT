//
//  SPoTTagTVC.m
//  SPoT
//
//  Created by Chris on 6/11/13.
//  Copyright (c) 2013 Chris Chapman. All rights reserved.
//

#import "SPoTTagTVC.h"

@interface SPoTTagTVC ()

@property (strong, nonatomic)NSString *tagTitle;

@end

@implementation SPoTTagTVC


-(void)setTagTitle:(NSString *)tagTitle
{
    _tagTitle = tagTitle;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self photosWithTag:self.tagTitle][row][FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSLog(@"%@",[[self photosWithTag:self.tagTitle][row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]) ;
    return [[self photosWithTag:self.tagTitle][row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    //NSLog(@"Number of cells: %d",[self.stanfordPhotos count]);
    //return [self.stanfordPhotos count];
    
    NSLog(@"%d",[[self photosWithTag:self.tagTitle] count]);
    
    return [[self photosWithTag:self.tagTitle] count];
}


@end
