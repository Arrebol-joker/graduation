package com.fast.ich.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.domain.model.LoginUser;
import com.fast.system.general.core.page.TableDataInfo;
import com.fast.system.domain.SysUser;
import com.fast.ich.domain.Comment;
import com.fast.ich.service.ICommentService;

@RestController
@RequestMapping("/ich/comment")
public class CommentController extends BaseController {
    @Autowired
    private ICommentService commentService;

    @GetMapping("/list")
    public TableDataInfo list(Comment comment) {
        startPage();
        List<Comment> list = commentService.selectCommentList(comment);
        return getDataTable(list);
    }

    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") String commentId) {
        return success(commentService.selectCommentByCommentId(commentId));
    }

    @GetMapping(value = "/target/{targetId}")
    public AjaxResult getCommentsByTargetId(@PathVariable("targetId") String targetId) {
        return success(commentService.selectCommentByTargetId(targetId));
    }

    @PostMapping
    public AjaxResult add(@RequestBody Comment comment) {
        LoginUser loginUser = getLoginUser();
        SysUser user = loginUser.getUser();
        comment.setUserId(user.getUserId());
        comment.setNickName(user.getNickName());
        comment.setAvatar(user.getAvatar());
        return toAjax(commentService.insertComment(comment));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody Comment comment) {
        return toAjax(commentService.updateComment(comment));
    }

    @DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable String[] commentIds) {
        return toAjax(commentService.deleteCommentByCommentIds(commentIds));
    }
}
