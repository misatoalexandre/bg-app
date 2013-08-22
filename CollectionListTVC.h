//
//  CollectionListTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/21/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"


@interface CollectionListTVC : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Favorite *selectedCollection;


@end
