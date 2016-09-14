//
//  QCCellDataAdapter.m
//  AdapterCell
//
//  Created by Joe on 16/8/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCCellDataAdapter.h"

@implementation QCCellDataAdapter

+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data
                                                 cellHeight:(CGFloat)cellHeight cellType:(NSInteger)cellType {
    
    QCCellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data
                                                 cellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth
                                                   cellType:(NSInteger)cellType {
    
    QCCellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellWidth           = cellWidth;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (instancetype)collectionCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data cellType:(NSInteger)cellType {
    
    QCCellDataAdapter *adapter    = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellType            = cellType;
    
    return adapter;
}

@end
