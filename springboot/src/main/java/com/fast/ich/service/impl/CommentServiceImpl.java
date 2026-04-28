package com.fast.ich.service.impl;

import java.util.List;

import com.fast.system.general.utils.DateUtils;
import com.fast.system.general.utils.uuid.IdUtils;
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
    public Comment selectCommentByCommentId(String commentId)
    {
        return commentMapper.selectCommentByCommentId(commentId);
    }

    @Override
    public List<Comment> selectCommentList(Comment comment)
    {
        return commentMapper.selectCommentList(comment);
    }

    @Override
    public List<Comment> selectCommentByTargetId(String targetId)
    {
        return commentMapper.selectCommentByTargetId(targetId);
    }

    @Override
    public int insertComment(Comment comment)
    {
        comment.setCreateTime(DateUtils.getNowDate());
        comment.setCommentId(IdUtils.fastSimpleUUID());
        return commentMapper.insertComment(comment);
    }

    @Override
    public int updateComment(Comment comment)
    {
        return commentMapper.updateComment(comment);
    }

    @Override
    public int deleteCommentByCommentIds(String[] commentIds)
    {
        return commentMapper.deleteCommentByCommentIds(commentIds);
    }

    @Override
    public int deleteCommentByCommentId(String commentId)
    {
        return commentMapper.deleteCommentByCommentId(commentId);
    }
}
