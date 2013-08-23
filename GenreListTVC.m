//
//  GenreListTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "GenreListTVC.h"
#import "Genre.h"
#import "BooksByGenreTVC.h"
#import "AppDelegate.h"


@interface GenreListTVC ()

@end

@implementation GenreListTVC
@synthesize fetchedResultsController=_fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    NSError *error=nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error %@", error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ViewDidLoad on Collection failed" message:@"Collection page did not load" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  


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
#pragma mark-NewGenreTVCDelegate Method
-(void) newGenreTVCSave:(NewGenreTVC *)controller{
    NSError *error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in saving new genre. %@", error);
    }
    
    [controller.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Navigation : prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newGenre"]) {
        NewGenreTVC *ngtvc=(NewGenreTVC *)[segue destinationViewController];
        ngtvc.delegate=self;
        
        Genre *newGenre=(Genre *)[NSEntityDescription insertNewObjectForEntityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
        ngtvc.currentGenre=newGenre;
    }
    if ([segue.identifier isEqualToString:@"books"]) {
        BooksByGenreTVC *bbgtvc=(BooksByGenreTVC *)[segue destinationViewController];
        AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSIndexPath *IndexPath=[self.tableView indexPathForSelectedRow];
        self.selectedGenre=[self.fetchedResultsController objectAtIndexPath:IndexPath];
        bbgtvc.selectedGenre=self.selectedGenre;
        bbgtvc.managedObjectContext=myApp.managedObjectContext;
        bbgtvc.title=self.selectedGenre.genre;
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Genre *genre=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.detailTextLabel.text=genre.genre;
    
    unsigned int bookCount=[genre.genreBooks count];
    
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
        Genre *genre=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:genre];
        
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Error %@", error);
        }
        
    }
    
}


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
