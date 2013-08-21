//
//  BookStatusTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

@protocol BookStatusTVCDelegate;

@interface BookStatusTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) id <BookStatusTVCDelegate> delegate;
@property (strong, nonatomic) Status *selectedStatus;

@end

@protocol BookStatusTVCDelegate

-(void)statusWasSelectedOnBookStatusnTVC:(BookStatusTVC*)controller;

@end


