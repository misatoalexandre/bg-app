//
//  Genre.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Genre : NSManagedObject

@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSSet *genreBooks;
@end

@interface Genre (CoreDataGeneratedAccessors)

- (void)addGenreBooksObject:(Book *)value;
- (void)removeGenreBooksObject:(Book *)value;
- (void)addGenreBooks:(NSSet *)values;
- (void)removeGenreBooks:(NSSet *)values;

@end
