package com.fast.ich.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.fast.system.general.annotation.Anonymous;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.domain.model.LoginUser;
import com.fast.system.general.core.page.TableDataInfo;
import com.fast.system.domain.SysUser;
import com.fast.ich.domain.Comment;
import com.fast.ich.service.ICommentService;

@RestController
@RequestMapping("/comment")
public class CommentController extends BaseController {
    @Autowired
    private ICommentService commentService;

    @Anonymous
    @GetMapping("/list")
    public AjaxResult list(@RequestParam("targetId") String targetId, @RequestParam("type") Integer type) {
        List<Comment> list = commentService.selectCommentList(targetId, type);
        return success(list);
    }

    @GetMapping("/myComments")
    public TableDataInfo myComments(Comment comment) {
        startPage();
        LoginUser loginUser = getLoginUser();
        comment.setUserId(loginUser.getUser().getUserId());
        List<Comment> list = commentService.selectCommentPage(comment);
        return getDataTable(list);
    }

    @PostMapping("/add")
    public AjaxResult add(@RequestBody Comment comment) {
        LoginUser loginUser = getLoginUser();
        SysUser user = loginUser.getUser();
        comment.setUserId(user.getUserId());
        comment.setNickName(user.getNickName());
        return toAjax(commentService.insertComment(comment));
    }

    @DeleteMapping("/delete/{id}")
    public AjaxResult delete(@PathVariable("id") Integer id) {
        LoginUser loginUser = getLoginUser();
        Long userId = loginUser.getUser().getUserId();
        return toAjax(commentService.deleteCommentById(id, userId));
    }
}
