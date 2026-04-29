package com.fast.ich.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.page.TableDataInfo;
import com.fast.ich.domain.Comment;
import com.fast.ich.service.ICommentService;

@RestController
@RequestMapping("/admin/comment")
public class AdminCommentController extends BaseController {
    @Autowired
    private ICommentService commentService;

    @PreAuthorize("@ss.hasPermi('ich:comment:list')")
    @GetMapping("/page")
    public TableDataInfo page(Comment comment) {
        startPage();
        List<Comment> list = commentService.selectCommentPage(comment);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ich:comment:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Integer id) {
        return success(commentService.selectCommentById(id));
    }

    @PreAuthorize("@ss.hasPermi('ich:comment:add')")
    @PostMapping
    public AjaxResult add(@RequestBody Comment comment) {
        return toAjax(commentService.insertComment(comment));
    }

    @PreAuthorize("@ss.hasPermi('ich:comment:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody Comment comment) {
        return toAjax(commentService.updateComment(comment));
    }

    @PreAuthorize("@ss.hasPermi('ich:comment:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Integer[] ids) {
        return toAjax(commentService.deleteCommentByIds(ids));
    }
}
