package com.fast.ich.service;

import java.util.List;
import com.fast.ich.domain.Comment;

public interface ICommentService
{
    public List<Comment> selectCommentList(String targetId, Integer type);

    public List<Comment> selectCommentPage(Comment comment);

    public Comment selectCommentById(Integer id);

    public int insertComment(Comment comment);

    public int updateComment(Comment comment);

    public int deleteCommentById(Integer id, Long userId);

    public int deleteCommentByIds(Integer[] ids);
}
