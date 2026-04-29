package com.fast.ich.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fast.ich.mapper.CommentMapper;
import com.fast.ich.domain.Comment;
import com.fast.ich.service.ICommentService;

@Service
public class CommentServiceImpl implements ICommentService
{
    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<Comment> selectCommentList(String targetId, Integer type)
    {
        return commentMapper.selectCommentList(targetId, type);
    }

    @Override
    public List<Comment> selectCommentPage(Comment comment)
    {
        return commentMapper.selectCommentPage(comment);
    }

    @Override
    public Comment selectCommentById(Integer id)
    {
        return commentMapper.selectCommentById(id);
    }

    @Override
    public int insertComment(Comment comment)
    {
        comment.setCreateTime(new Date());
        return commentMapper.insertComment(comment);
    }

    @Override
    public int updateComment(Comment comment)
    {
        return commentMapper.updateComment(comment);
    }

    @Override
    public int deleteCommentById(Integer id, Long userId)
    {
        return commentMapper.deleteCommentById(id, userId);
    }

    @Override
    public int deleteCommentByIds(Integer[] ids)
    {
        return commentMapper.deleteCommentByIds(ids);
    }
}
