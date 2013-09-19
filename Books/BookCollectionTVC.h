//
//  BookCollectionTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
#import "BookCollectionDetailTVC.h"


@protocol BookCollectionTVCDelegate;

@interface BookCollectionTVC : UITableViewController <NSFetchedResultsControllerDelegate, BookCollectionDetailTVCDelegate>

@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) id <BookCollectionTVCDelegate> delegate;
@property (strong, nonatomic)Favorite *selectedCollection;

@end

@protocol BookCollectionTVCDelegate

-(void)collectionWasSelectedOnBookCollectionTVC:(BookCollectionTVC*)controller;
@end





