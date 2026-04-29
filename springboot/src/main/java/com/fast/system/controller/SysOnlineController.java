package com.fast.system.controller;

import com.fast.system.domain.SysUserOnline;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.general.core.page.TableDataInfo;
import com.fast.system.configure.web.service.SysOnlineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collection;

@RestController
@RequestMapping("/system/online")
public class SysOnlineController extends BaseController
{
    @Autowired
    private SysOnlineService onlineService;

    @PreAuthorize("@ss.hasPermi('system:online:list')")
    @GetMapping("/list")
    public TableDataInfo list(String userName, String ipaddr)
    {
        Collection<SysUserOnline> list = onlineService.selectOnlineList(userName, ipaddr);
        TableDataInfo dataTable = getDataTable(new ArrayList<>(list));
        return dataTable;
    }

    @PreAuthorize("@ss.hasPermi('system:online:forceLogout')")
    @DeleteMapping("/{tokenId}")
    public AjaxResult forceLogout(@PathVariable String tokenId)
    {
        onlineService.removeLogin(tokenId);
        return success();
    }
}
