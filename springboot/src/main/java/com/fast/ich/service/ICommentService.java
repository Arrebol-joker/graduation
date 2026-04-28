package com.fast.ich.service;

import java.util.List;
import com.fast.ich.domain.Comment;

public interface ICommentService
{
    public Comment selectCommentByCommentId(String commentId);

    public List<Comment> selectCommentList(Comment comment);

    public List<Comment> selectCommentByTargetId(String targetId);

    public int insertComment(Comment comment);

    public int updateComment(Comment comment);

    public int deleteCommentByCommentIds(String[] commentIds);

    public int deleteCommentByCommentId(String commentId);
}
