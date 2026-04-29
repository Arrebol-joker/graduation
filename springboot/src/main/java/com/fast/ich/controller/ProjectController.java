package com.fast.ich.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
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

import java.io.InputStream;

import org.springframework.web.multipart.MultipartFile;
import com.fast.ich.domain.Project;
import com.fast.ich.domain.Heritage;
import com.fast.ich.service.IProjectService;
import com.fast.ich.service.IHeritageService;
import com.fast.system.domain.SysUser;
import com.fast.system.service.ISysUserService;
import com.fast.system.general.utils.poi.ExcelUtil;
import com.fast.system.general.core.page.TableDataInfo;

/**
 * 项目申报Controller
 *
 * @author fast
 * @date 2025-11-06
 */
@RestController
@RequestMapping("/ich/project")
public class ProjectController extends BaseController {
    @Autowired
    private IProjectService projectService;

    @Autowired
    private IHeritageService heritageService;

    @Autowired
    private ISysUserService sysUserService;

    /**
     * 查询项目申报列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Project project) {
        startPage();
        List<Project> list = projectService.selectProjectList(project);
        return getDataTable(list);
    }

    /**
     * 导出项目申报列表
     */
    @PostMapping("/export")
    public void export(HttpServletResponse response, Project project) {
        List<Project> list = projectService.selectProjectList(project);
        ExcelUtil<Project> util = new ExcelUtil<Project>(Project. class);
        util.exportExcel(response, list, "项目申报数据");
    }

    /**
     * 下载模板
     */
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Project> util = new ExcelUtil<Project>(Project. class);
        util.importTemplateExcel(response, "项目申报数据");
    }

    /**
     * 导入数据
     */
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception {
        ExcelUtil<Project> util = new ExcelUtil<Project>(Project. class);
        InputStream inputStream = file.getInputStream();
        List<Project> list = util.importExcel(inputStream);
        inputStream.close();
        int count = projectService.batchInsertProject(list);
        return AjaxResult.success("导入成功" + count + "条信息！");
    }

    /**
     * 获取项目申报详细信息
     */
    @GetMapping(value = "/{projectId}")
    public AjaxResult getInfo(@PathVariable("projectId") String projectId) {
        return success(projectService.selectProjectByProjectId(projectId));
    }

    /**
     * 新增项目申报
     */
    @PostMapping
    public AjaxResult add(@RequestBody Project project) {
        return toAjax(projectService.insertProject(project));
    }

    /**
     * 修改项目申报
     */
    @PutMapping
    public AjaxResult edit(@RequestBody Project project) {
        return toAjax(projectService.updateProject(project));
    }

    /**
     * 删除项目申报
     */
    @DeleteMapping("/{projectIds}")
    public AjaxResult remove(@PathVariable String[] projectIds) {
        return toAjax(projectService.deleteProjectByProjectIds(projectIds));
    }

    /**
     * 审核通过
     */
    @PutMapping("/approve/{projectId}")
    public AjaxResult approve(@PathVariable String projectId) {
        // 更新项目审核状态
        Project project = new Project();
        project.setProjectId(projectId);
        project.setStatus(1); // 1-已通过
        int result = projectService.updateProject(project);

        if (result > 0) {
            // 检查是否已经同步到heritage表
            Heritage existingHeritage = heritageService.selectHeritageByHeritageId(projectId);
            if (existingHeritage == null) {
                // 获取完整的项目信息
                Project fullProject = projectService.selectProjectByProjectId(projectId);

                // 将项目数据同步到heritage表
                Heritage heritage = new Heritage();
                heritage.setHeritageId(fullProject.getProjectId()); // 使用项目ID作为非遗ID
                heritage.setTitle(fullProject.getName()); // 项目名称
                heritage.setDescription(fullProject.getIntroduction()); // 项目简介
                heritage.setDetailDescription(fullProject.getDescription()); // 详细描述
                heritage.setImage(fullProject.getImageUrl()); // 图片
                heritage.setLocation("未知"); // 所在地，默认值
                heritage.setCategory(fullProject.getCategoryName()); // 类别
                heritage.setStatus("传承中"); // 传承状态，默认值
                heritage.setHeritageStatus("2");
                heritage.setHeritageOwnerId(fullProject.getUserId());

                heritageService.insertHeritage(heritage);
            }

            // 将申报用户升级为传承人（无论heritage是否已存在，都要执行）
            Project fullProject = projectService.selectProjectByProjectId(projectId);
            if (fullProject != null && fullProject.getUserId() != null) {
                SysUser sysUser = new SysUser();
                sysUser.setUserId(fullProject.getUserId());
                sysUser.setAccountType("1");
                sysUserService.updateUser(sysUser);
            }
        }

        return toAjax(result);
    }

    /**
     * 审核拒绝
     */
    @PutMapping("/reject/{projectId}")
    public AjaxResult reject(@PathVariable String projectId) {
        Project project = new Project();
        project.setProjectId(projectId);
        project.setStatus(2); // 2-已拒绝
        return toAjax(projectService.updateProject(project));
    }
}
