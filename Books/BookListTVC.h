//
//  BookListTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailTVC.h"
#import "Book.h"



@interface BookListTVC : UITableViewController <NSFetchedResultsControllerDelegate,BookDetailTVCDelegate,UISearchBarDelegate>


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) Book *selectedBook;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end

