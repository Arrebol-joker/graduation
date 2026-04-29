package com.fast.ich.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment
{
    private Integer id;

    private String content;

    private Long userId;

    private String targetId;

    private Integer type;

    private String nickName;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String targetName;
}
