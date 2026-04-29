package com.fast.ich.controller;

import com.fast.ich.domain.Heritage;
import com.fast.ich.service.IHeritageService;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.page.TableDataInfo;
import com.fast.system.general.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/heritage/owner")
public class HeritageOwnerController extends BaseController {

    @Autowired
    private IHeritageService heritageService;

    @GetMapping("/list")
    public TableDataInfo list(Heritage heritage) {
        startPage();
        Long userId = SecurityUtils.getUserId();
        heritage.setHeritageOwnerId(userId);
        List<Heritage> list = heritageService.selectHeritageList(heritage);
        return getDataTable(list);
    }

    @GetMapping("/{heritageId}")
    public AjaxResult getInfo(@PathVariable String heritageId) {
        Heritage heritage = heritageService.selectHeritageByHeritageId(heritageId);
        Long userId = SecurityUtils.getUserId();
        if (heritage != null && !userId.equals(heritage.getHeritageOwnerId())) {
            return error("无权访问该项目");
        }
        return success(heritage);
    }

    @PostMapping
    public AjaxResult add(@RequestBody Heritage heritage) {
        Long userId = SecurityUtils.getUserId();
        heritage.setHeritageOwnerId(userId);
        heritage.setHeritageStatus("0");
        return toAjax(heritageService.insertHeritage(heritage));
    }

    @PutMapping
    public AjaxResult edit(@RequestBody Heritage heritage) {
        Long userId = SecurityUtils.getUserId();
        Heritage existing = heritageService.selectHeritageByHeritageId(heritage.getHeritageId());
        if (existing == null || !userId.equals(existing.getHeritageOwnerId())) {
            return error("无权修改该项目");
        }
        if (!"0".equals(existing.getHeritageStatus())) {
            return error("仅允许修改待申报的项目");
        }
        heritage.setHeritageOwnerId(userId);
        heritage.setHeritageStatus("0");
        return toAjax(heritageService.updateHeritage(heritage));
    }

    @PutMapping("/submit/{heritageId}")
    public AjaxResult submit(@PathVariable String heritageId) {
        Long userId = SecurityUtils.getUserId();
        Heritage existing = heritageService.selectHeritageByHeritageId(heritageId);
        if (existing == null || !userId.equals(existing.getHeritageOwnerId())) {
            return error("无权操作该项目");
        }
        if (!"0".equals(existing.getHeritageStatus())) {
            return error("仅允许提交待申报的项目");
        }
        Heritage update = new Heritage();
        update.setHeritageId(heritageId);
        update.setHeritageStatus("1");
        return toAjax(heritageService.updateHeritage(update));
    }

    @DeleteMapping("/{heritageIds}")
    public AjaxResult remove(@PathVariable String[] heritageIds) {
        Long userId = SecurityUtils.getUserId();
        for (String id : heritageIds) {
            Heritage existing = heritageService.selectHeritageByHeritageId(id);
            if (existing == null || !userId.equals(existing.getHeritageOwnerId())) {
                return error("无权删除项目：" + id);
            }
            if (!"0".equals(existing.getHeritageStatus())) {
                return error("仅允许删除待申报的项目");
            }
        }
        return toAjax(heritageService.deleteHeritageByHeritageIds(heritageIds));
    }

    @GetMapping("/stats")
    public AjaxResult stats() {
        Long userId = SecurityUtils.getUserId();
        Heritage query = new Heritage();
        query.setHeritageOwnerId(userId);
        List<Heritage> all = heritageService.selectHeritageList(query);
        long draft = all.stream().filter(h -> "0".equals(h.getHeritageStatus())).count();
        long pending = all.stream().filter(h -> "1".equals(h.getHeritageStatus())).count();
        long approved = all.stream().filter(h -> "2".equals(h.getHeritageStatus())).count();
        long rejected = all.stream().filter(h -> "3".equals(h.getHeritageStatus())).count();
        return success(new long[]{draft, pending, approved, rejected});
    }
}
