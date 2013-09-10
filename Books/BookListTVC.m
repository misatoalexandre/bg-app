//
//  BookListTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookListTVC.h"
#import "Book.h"

@interface BookListTVC ()
@end

@implementation BookListTVC
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
    
    //[self.delegate bookListTVCDelegate:self.fetchedResultsController.fetchedObjects.count];
    
    //Perform fetch
    NSError *error=nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error %@", error);
        abort() ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Search Bar Section
-(void) searchBar: (UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([[searchBar text] length] >0)
    {
        NSPredicate *authorPredicate=[NSPredicate predicateWithFormat:@"title CONTAINS [cd] %@ OR author CONTAINS [cd] %@",[searchBar text],[searchBar text]];
        [self.fetchedResultsController.fetchRequest setPredicate:authorPredicate];
    }else{
        [self.fetchedResultsController.fetchRequest setPredicate:nil];
    }
    NSError *error=nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@", error);
    }
    [self.tableView reloadData];
    return;
    
}
#pragma mark-BookDetailTVCDelegate Section
-(void)bookDetailTVCDelegateSave:(BookDetailTVC *)controller{
    NSError *error=nil;
    NSManagedObjectContext *context=self.managedObjectContext;
    
    if (![context save:&error]) {
        NSLog(@"Error %@",error);
    }
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark-prepare for segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BookDetailTVC *bdtvc=(BookDetailTVC *)[segue destinationViewController];
    bdtvc.delegate=self;
    
    if ([segue.identifier isEqualToString:@"addBook"]) {
        Book *newBook=(Book *)[NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
        bdtvc.currentBook=newBook;
        bdtvc.title=@"Add a Book";
        
    }else{
        NSIndexPath *IndexPath=[self.tableView indexPathForSelectedRow];
        // Book *selectedBook=(Book *)[self.fetchedResultsController objectAtIndexPath:IndexPath];
        self.selectedBook=[self.fetchedResultsController objectAtIndexPath:IndexPath];
        bdtvc.currentBook=self.selectedBook;
        bdtvc.title=@"Book Details";
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
    
    NSInteger rowCount=[[[self.fetchedResultsController sections]objectAtIndex:section] numberOfObjects];
    NSDictionary *bookCount= [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:rowCount],@"books", nil];
    //Post notification "TotalBookCount"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TotalBookCount" object:self userInfo:bookCount];
    return rowCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Book *book=[self.fetchedResultsController objectAtIndexPath:indexPath];
    //self.selectedBook=[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=book.title;
    cell.detailTextLabel.text=book.author;
    
    /*Book *book=[self.fetchedResultsController objectAtIndexPath:indexPath];
     //NSString *titleGenreCollection=[NSString stringWithFormat:@"%@ %@ %@", book.title, book.genre.genre, book.favorite.favorite];
     // cell.textLabel.text=titleGenreCollection;
     cell.textLabel.text=book.title;
     NSString *byAuthorAndStatus=[NSString stringWithFormat:@"by %@ %@", book.author,book.status.readingStatus];
     cell.detailTextLabel.text=byAuthorAndStatus;*/
    
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context=self.managedObjectContext;
        //Book *book=[self.fetchedResultsController objectAtIndexPath:indexPath];
        //[context deleteObject:book];
        self.selectedBook=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:self.selectedBook];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptorZero= [[NSSortDescriptor alloc] initWithKey:@"dateAdded"
                                                                      ascending:NO];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    NSSortDescriptor *sortDescriptorTwo = [[NSSortDescriptor alloc] initWithKey:@"author"
                                                                      ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorZero,sortDescriptor,sortDescriptorTwo,nil];
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
            Book *changedBook=[self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text=changedBook.title;
            //cell.detailTextLabel.text=changedBook.genre.genre;
            NSString *byAuthor=[NSString stringWithFormat:@"by %@", changedBook.author];
            cell.detailTextLabel.text=byAuthor;
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
