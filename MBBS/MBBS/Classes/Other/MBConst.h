

#import <UIKit/UIKit.h>

typedef enum{
    MBTopicTypeAll = 1,
    MBTopicTypePicture = 10,
    MBTopicTypeVideo = 41,
    MBTopicTypeVoice = 31,
    MBTopicTypeWord = 29,
}MBTopicType;


/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const MBTitleViewH ;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const MBTitleViewY ;
/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const MBTopicCellMargin ;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const MBTopicCellTextY ;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const MBTopicCellBottomBarH ;
/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const MBTopicCellPictureH ;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const MBTopicCellPictureBreakH ;