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

//@protocol BookListTVCDelegate;

@interface BookListTVC : UITableViewController <NSFetchedResultsControllerDelegate,BookDetailTVCDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *bookSearch;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Book *selectedBook;
//@property (strong, nonatomic) id<BookListTVCDelegate> delegate;

@end

/*@protocol BookListTVCDelegate
-(void)bookListTVCDelegate:(NSInteger)bookCount;

@end*/