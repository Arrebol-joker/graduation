package com.fast.ich.domain;

import com.fast.system.general.annotation.Excel;
import com.fast.system.general.core.domain.BaseEntity;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private String commentId;

    @Excel(name = "评论内容")
    private String content;

    @Excel(name = "目标ID")
    private String targetId;

    @Excel(name = "目标类型")
    private String targetType;

    private Long userId;

    private String nickName;

    private String avatar;
}
