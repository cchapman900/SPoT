//
//  SPoTViewAllTVC.m
//  SPoT
//
//  Created by Chris on 6/11/13.
//  Copyright (c) 2013 Chris Chapman. All rights reserved.
//

#import "SPoTTVC.h"
#import "FlickrFetcher.h"

@interface SPoTTVC ()

@property (strong, nonatomic)NSArray *stanfordPhotos;


@end

@implementation SPoTTVC

//My methods

@synthesize stanfordPhotos = _stanfordPhotos;

-(NSArray *)stanfordPhotos
{
    if (!_stanfordPhotos) _stanfordPhotos = [FlickrFetcher stanfordPhotos];
    
    return _stanfordPhotos;
}

-(void)setStanfordPhotos
{
    _stanfordPhotos = [FlickrFetcher stanfordPhotos];
    
    [self.tableView reloadData];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    //return [self.stanfordPhotos[row][FLICKR_PHOTO_TITLE] description]; // description because could be NSNull
    return [[self tags][row] description]; // description because could be NSNull
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    //return [self.stanfordPhotos[row][FLICKR_PHOTO_DESCRIPTION] description]; // description because could be NSNull
    return [[self tagsAndCount][[self tags][row]] description];
}

-(NSArray *)ignoreStrings
{
    return @[@"cs193pspot", @"landscape", @"portrait"];
}

- (NSMutableDictionary *) tagsAndCount
{
    NSMutableDictionary *photosAndCount = [[NSMutableDictionary alloc] init];
    for (NSDictionary *photo in self.stanfordPhotos) {
        NSString *tagsString = photo[FLICKR_TAGS];
        NSArray *tagsArray = [tagsString componentsSeparatedByString:@" "];
        for (NSString *tag in tagsArray) {
            if (![[self ignoreStrings] containsObject:tag]) {
                NSString *upperCaseTag = [tag capitalizedString];
                NSUInteger count = [[photosAndCount objectForKey:upperCaseTag] intValue];
                count += 1;
                [photosAndCount setObject:[NSNumber numberWithUnsignedInt:count] forKey:upperCaseTag];
            }
        }
    }
    
    return photosAndCount;
}

-(NSArray *)tags
{
    NSMutableDictionary *tagsAndCount = [self tagsAndCount];
    NSArray *tags = [tagsAndCount keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return tags;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Tab Table"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setTagTitle:)]) {
                    [segue.destinationViewController performSelector:@selector(setTagTitle:) withObject:[self titleForRow:indexPath.row]];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}

//end my methods

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    //NSLog(@"Number of cells: %d",[self.stanfordPhotos count]);
    //return [self.stanfordPhotos count];
    
    return [[self tags] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tags Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    //this needs to be changed. Need a method to group tags
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
