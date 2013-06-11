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
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
}


@end
