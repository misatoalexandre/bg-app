//
//  Status.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Status : NSManagedObject

@property (nonatomic, retain) NSString * readingStatus;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSSet *statusBooks;
@end

@interface Status (CoreDataGeneratedAccessors)

- (void)addStatusBooksObject:(Book *)value;
- (void)removeStatusBooksObject:(Book *)value;
- (void)addStatusBooks:(NSSet *)values;
- (void)removeStatusBooks:(NSSet *)values;

@end
