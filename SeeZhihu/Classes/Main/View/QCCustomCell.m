//
//  QCCustomCell.m
//  AdapterCell
//
//  Created by Joe on 16/8/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCCustomCell.h"
#import "QCCellDataAdapter.h"

@implementation QCCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}

- (void)setWeakReferenceWithCellDataAdapter:(QCCellDataAdapter *)dataAdapter data:(id)data
                                  indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    _dataAdapter = dataAdapter;
    _data        = data;
    _indexPath   = indexPath;
    _tableView   = tableView;
}

+ (QCCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [QCCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (QCCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data
                                             cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [QCCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (QCCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [QCCellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:type];
}

+ (QCCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {
    
    return [QCCellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:0];
}

+ (QCCellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [QCCellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 cellType:0];
}

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (_tableView && _dataAdapter) {
        
        if (animated) {
            
            _dataAdapter.cellHeight = height;
            [_tableView beginUpdates];
            [_tableView endUpdates];
            
        } else {
            
            _dataAdapter.cellHeight = height;
            [_tableView reloadData];
        }
    }
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}
@end
