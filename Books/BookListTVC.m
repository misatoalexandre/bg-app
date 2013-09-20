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
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];

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
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar  {
    [self.searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}


#pragma mark-BookDetailTVCDelegate Section
-(void)saveAndFetch{
    NSError *error=nil;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error %@",error);
    }
    
   /* if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error %@", error);
        abort() ;
    }*/
    [self.tableView reloadData];

}
-(void)bookDetailTVCDelegateSave{
    [self saveAndFetch];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)bookDetailTVCDelegateCancel:(Book *)bookToDelete{
    [self.managedObjectContext deleteObject:bookToDelete];
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)bookDetailTVCDelegateSavePush:(BookDetailTVC *)controller{
    [self saveAndFetch];
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark-prepare for segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BookDetailTVC *bdtvc=(BookDetailTVC *)[segue destinationViewController];
    bdtvc.delegate=self;
    
    if ([segue.identifier isEqualToString:@"addBook"]) {
        Book *newBook=(Book *)[NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
        bdtvc.currentBook=newBook;
        bdtvc.title=@"New Book";
        
        
        
    }else{
        NSIndexPath *IndexPath=[self.tableView indexPathForSelectedRow];
        // Book *selectedBook=(Book *)[self.fetchedResultsController objectAtIndexPath:IndexPath];
        self.selectedBook=[self.fetchedResultsController objectAtIndexPath:IndexPath];
        bdtvc.currentBook=self.selectedBook;
        NSLog(@"self.selectedBook Status is %@", self.selectedBook.status.readingStatus);
        NSLog(@"self.selectedBook Category is %@", self.selectedBook.genre.genre);
        NSLog(@"self.selectedBook Collection is %@", self.selectedBook.favorite.favorite);
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
{
    
    NSInteger totalBookCount=[self.fetchedResultsController.fetchedObjects count];
    
    NSDictionary *bookCount= [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:totalBookCount],@"books", nil];
    //Post notification "TotalBookCount"
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TotalBookCount" object:self userInfo:bookCount];
    
    NSInteger rowCount=[[[self.fetchedResultsController sections]objectAtIndex:section] numberOfObjects];
    return rowCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    self.selectedBook =[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text=self.selectedBook.title ;
    if (self.selectedBook.genre.genre ==nil) {
        NSString *byAuthor=[NSString stringWithFormat:@"by %@", self.selectedBook.author];
        cell.detailTextLabel.text=byAuthor;
    }else{
        NSString *byAuthorAndCategory=[NSString stringWithFormat:@"by %@  in %@ ", self.selectedBook.author, self.selectedBook.genre.genre];
        cell.detailTextLabel.text=byAuthorAndCategory;
    }
    
   
    
    
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
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController=[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    //@"status.readingStatus" sectionNameKeyPath
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
            
            if (changedBook.genre.genre ==nil) {
                NSString *byAuthor=[NSString stringWithFormat:@"by %@", changedBook.author];
                cell.detailTextLabel.text=byAuthor;
            }else{
                NSString *byAuthorAndCategory=[NSString stringWithFormat:@"by %@  in %@ ", changedBook.author, changedBook.genre.genre];
                cell.detailTextLabel.text=byAuthorAndCategory;
            }
            
           
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


//Resigning searchbar keyboard
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];
    return indexPath;
}





@end
