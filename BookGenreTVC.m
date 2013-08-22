//
//  BookGenreTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookGenreTVC.h"
#import "Genre.h"

@interface BookGenreTVC ()

@end

@implementation BookGenreTVC
@synthesize fetchedResultsController=_fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-Default value setting
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (![[self.fetchedResultsController fetchedObjects]count] >0) {
        [self importCoreDataDefaultsGenres];
    }else{
       
    }
}
-(void) insertGenrewithGenre:(NSString *)genreTitle{
    Genre *genre=[NSEntityDescription insertNewObjectForEntityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
    genre.genre=genreTitle;
    [self.managedObjectContext save:nil];
}
-(void)importCoreDataDefaultsGenres{
    [self insertGenrewithGenre:@"Arts & Entertainment"];
    [self insertGenrewithGenre:@"Biographies & Memoirs"];
    [self insertGenrewithGenre:@"Business & Investing"];
    [self insertGenrewithGenre:@"Children's Books"];
    [self insertGenrewithGenre:@"Children's Books: Ages 9-12"];
    [self insertGenrewithGenre:@"Comics & Graphic Novels"];
    [self insertGenrewithGenre:@"Computers & Technology"];
    [self insertGenrewithGenre:@"Cooking, Food & Wine"];
    [self insertGenrewithGenre:@"Education"];
    [self insertGenrewithGenre:@"Engineering"];
    [self insertGenrewithGenre:@"Fiction & Literature"];
    [self insertGenrewithGenre:@"Health, Mind & Body"];
    [self insertGenrewithGenre:@"History"];
    [self insertGenrewithGenre:@"Home & Garden"];
    [self insertGenrewithGenre:@"Law"];
 
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error=nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error %@", error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ViewDidLoad on Genre failed" message:@"Genre page did not load" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Prepare for segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   

    if ([segue.identifier isEqualToString:@"addGenre"]) {
        BookGenreDetailTVC *bgdtvc=(BookGenreDetailTVC *)[segue destinationViewController];
        bgdtvc.delegate=self;
        Genre *newGenre=(Genre *)[NSEntityDescription insertNewObjectForEntityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
        bgdtvc.currentGenre=newGenre;
    }/*else{
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        Genre *selectedGenre=(Genre *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        bgdtvc.currentGenre=selectedGenre;
    }*/
}
-(void)bookGenreDetailTVCDelegateSave:(BookGenreDetailTVC *)controller{
    NSError *error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in saving new genre. %@", error);
    }
    [controller.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> secInfo=[[self.fetchedResultsController sections]objectAtIndex:section];
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Genre *genre=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=genre.genre;
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedGenre=[self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate genreWasSelectedOnBookGenreTVC:self];
}


// Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context=self.managedObjectContext;
        Genre *genre=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:genre];
        
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Error %@", error);
        }
    }
    
}


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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */
#pragma mark-Fetched Results Controller Section
-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController!=nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Genre"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"genre"
                                                                   ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate=self;
    return _fetchedResultsController;
    
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:{
            Genre *changedGenre=[self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text=changedGenre.genre;
        }
            
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
}

@end
