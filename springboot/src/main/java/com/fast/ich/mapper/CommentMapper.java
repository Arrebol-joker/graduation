package com.fast.ich.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.fast.ich.domain.Comment;

@Mapper
public interface CommentMapper
{
    public List<Comment> selectCommentList(@Param("targetId") String targetId, @Param("type") Integer type);

    public List<Comment> selectCommentPage(Comment comment);

    public Comment selectCommentById(Integer id);

    public int insertComment(Comment comment);

    public int updateComment(Comment comment);

    public int deleteCommentById(@Param("id") Integer id, @Param("userId") Long userId);

    public int deleteCommentByIds(Integer[] ids);
}
