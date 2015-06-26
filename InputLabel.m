//
//  InputLabel.m
//  testInputLabel
//
//  Created by Piao Piao on 15/6/26.
//  Copyright (c) 2015年 Piao Piao. All rights reserved.
//

#import "InputLabel.h"

@interface InputLabel()<UITextViewDelegate>
@property(nonatomic,strong) UITextView* invisibleTextView;
@property(nonatomic,strong) UILabel* labelContent;
@property(nonatomic,strong) NSDictionary* ds;
@property(nonatomic,strong) NSMutableArray* allConstraints;
@end

@implementation InputLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)commonInit
{
    self.invisibleTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.invisibleTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.invisibleTextView.delegate = self;
    [self addSubview:self.invisibleTextView];
    
    self.labelContent = [UILabel new];
    self.labelContent.backgroundColor = [UIColor redColor];
    self.labelContent.numberOfLines = 0;
    self.labelContent.text = @"test";
    _labelContent.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.labelContent];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self commonInit];
    }
    
    return self;
}
- (instancetype) init
{
    self = [super init];
    if(self)
    {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self commonInit];
    }
    
    return self;
}


- (void)updateConstraints
{
    [self removeConstraints:[NSArray arrayWithArray:self.allConstraints]];
    self.allConstraints = [NSMutableArray array];
    self.ds = NSDictionaryOfVariableBindings(_labelContent,_invisibleTextView);
    NSArray* HConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_invisibleTextView(0)][_labelContent]|" options:0 metrics:nil views:self.ds];
    NSArray* VConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_invisibleTextView(0)][_labelContent]|" options:0 metrics:nil views:self.ds];
    [self.allConstraints addObjectsFromArray:HConstraints];
    [self.allConstraints addObjectsFromArray:VConstraints];
    
    [self addConstraints:self.allConstraints];


    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return [self.labelContent intrinsicContentSize];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.invisibleTextView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.labelContent.text = textView.text;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
@end
