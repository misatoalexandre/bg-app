//
//  CollectionListTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "CollectionListTVC.h"
#import "AppDelegate.h"
#import "BooksByCollectionTVC.h"


@interface CollectionListTVC ()

@end

@implementation CollectionListTVC
@synthesize fetchedResultsController=_fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
        [super viewDidLoad];
        NSError *error=nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            NSLog(@"Error %@", error);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ViewDidLoad on Collection failed" message:@"Collection page did not load" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

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
#pragma mark- newCollectionTVCDelegate method
-(void)newCollectionTVCSave:(NewCollectionTVC *)controller{
    NSError *error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in saving new genre. %@", error);
    }

    [controller.navigationController popViewControllerAnimated:YES];
}
#pragma mark-prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"newCollection"]) {
        NewCollectionTVC *nctvc=(NewCollectionTVC *)[segue destinationViewController];
        nctvc.delegate=self;
        
        Favorite *newFavorite=(Favorite *)[NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:self.managedObjectContext];
        nctvc.currentFavorite=newFavorite;
    }
    if ([segue.identifier isEqualToString:@"booksByCollection"]) {
        BooksByCollectionTVC *bbctvc=(BooksByCollectionTVC *)[segue destinationViewController];
        AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSIndexPath *IndexPath=[self.tableView indexPathForSelectedRow];
        self.selectedCollection=[self.fetchedResultsController objectAtIndexPath:IndexPath];
        bbctvc.selectedFavorite=self.selectedCollection;
        bbctvc.managedObjectContext=myApp.managedObjectContext;
        bbctvc.title=self.selectedCollection.favorite;
    }
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
    static NSString *CellIdentifier = @"collectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Favorite *favorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.detailTextLabel.text=favorite.favorite;
    
    unsigned int bookCount=[favorite.favoriteBooks count];
    
    if (bookCount > 1 ) {
        NSString *bookCountDisplay=[NSString stringWithFormat:@"%d books", bookCount];
        cell.textLabel.text=bookCountDisplay;
    } else{
        NSString *noBookCountDisplay=[NSString stringWithFormat:@"%d book", bookCount];
        cell.textLabel.text=noBookCountDisplay;
    }
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context=self.managedObjectContext;
        Favorite *favorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:favorite];
        
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


#pragma mark-Fetched Results Controller Section
-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController!=nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"favorite"
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
            Favorite *changedFavorite=[self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text=changedFavorite.favorite;
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
