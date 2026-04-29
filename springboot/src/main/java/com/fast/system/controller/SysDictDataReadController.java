package com.fast.system.controller;

import com.fast.system.domain.SysDictData;
import com.fast.system.general.core.controller.BaseController;
import com.fast.system.general.core.domain.AjaxResult;
import com.fast.system.service.ISysDictTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/system/dict/data")
public class SysDictDataReadController extends BaseController {

    @Autowired
    private ISysDictTypeService dictTypeService;

    @GetMapping("/type/{dictType}")
    public AjaxResult getDicts(@PathVariable String dictType) {
        List<SysDictData> data = dictTypeService.selectDictDataByType(dictType);
        return success(data);
    }
}
