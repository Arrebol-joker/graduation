package com.fast.ich.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.fast.ich.domain.Comment;

@Mapper
public interface CommentMapper
{
    public Comment selectCommentByCommentId(String commentId);

    public List<Comment> selectCommentList(Comment comment);

    public List<Comment> selectCommentByTargetId(String targetId);

    public int insertComment(Comment comment);

    public int updateComment(Comment comment);

    public int deleteCommentByCommentId(String commentId);

    public int deleteCommentByCommentIds(String[] commentIds);
}
