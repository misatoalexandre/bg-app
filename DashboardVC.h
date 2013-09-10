//
//  DashboardVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/26/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BookListTVC.h"



@interface DashboardVC : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *totalBookCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *readBookCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularCategory;




@end
