package com.fast.ich.controller;

import com.fast.ich.domain.*;
import com.fast.ich.domain.vo.BarVO;
import com.fast.ich.domain.vo.HomeCountVo;
import com.fast.ich.domain.vo.PieVO;
import com.fast.ich.service.*;
import com.fast.system.domain.SysUser;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping("/home/page")
public class HomePageController extends BaseController {
    @Autowired
    private IHeritageService heritageService;
    @Autowired
    private IMasterService masterService;
    @Autowired
    private INewsService newsService;
    @Autowired
    private ISysUserService userService;
    @Autowired
    private IEventService eventService;
    @Autowired
    private IContactService contactService;
    @Autowired
    private ICommentService commentService;

    @GetMapping("/selectHomeCount")
    public AjaxResult selectHomeCount() {
        int heritageCount = heritageService.selectHeritageList(new Heritage()).size();
        int masterCount = masterService.selectMasterList(new Master()).size();
        int newsCount = newsService.selectNewsList(new News()).size();
        int userCount = userService.selectUserList(new SysUser()).size();
        int eventCount = eventService.selectEventList(new Event()).size();
        int contactCount = contactService.selectContactList(new Contact()).size();
        int commentCount = commentService.selectCommentList(null, null).size();

        HomeCountVo homeCountVo = new HomeCountVo();
        homeCountVo.setHeritageCount(heritageCount);
        homeCountVo.setMasterCount(masterCount);
        homeCountVo.setNewsCount(newsCount);
        homeCountVo.setUserCount(userCount);
        homeCountVo.setEventCount(eventCount);
        homeCountVo.setContactCount(contactCount);
        homeCountVo.setCommentCount(commentCount);
        return AjaxResult.success(homeCountVo);
    }

    @GetMapping("/selectBarData")
    public AjaxResult selectBarData() {
        int heritageCount = heritageService.selectHeritageList(new Heritage()).size();
        int masterCount = masterService.selectMasterList(new Master()).size();
        int newsCount = newsService.selectNewsList(new News()).size();
        int userCount = userService.selectUserList(new SysUser()).size();
        int eventCount = eventService.selectEventList(new Event()).size();
        int contactCount = contactService.selectContactList(new Contact()).size();
        int commentCount = commentService.selectCommentList(null, null).size();

        String[] categories = {"非遗项目", "传承人", "新闻资讯", "用户", "活动预告", "留言反馈", "评论"};
        Integer[] data = {heritageCount, masterCount, newsCount, userCount, eventCount, contactCount, commentCount};
        BarVO barVO = new BarVO();
        barVO.setCategories(categories);
        barVO.setData(data);
        return success(barVO);
    }

    @GetMapping("/selectPieData")
    public AjaxResult selectPieData() {
        List<PieVO> pieVoList = heritageService.selectCategoryChart();
        return success(pieVoList);
    }

    @GetMapping("/selectStatusPieData")
    public AjaxResult selectStatusPieData() {
        List<PieVO> pieVoList = heritageService.selectStatusChart();
        return success(pieVoList);
    }
}