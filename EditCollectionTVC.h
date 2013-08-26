//
//  EditCollectionTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/23/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
#import "CollectionListTVC.h"

@interface EditCollectionTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *collectionField;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableViewCell;

@property (strong, nonatomic) Favorite *selectedCollection;

- (IBAction)edit:(id)sender;
- (IBAction)save:(id)sender;

@end
