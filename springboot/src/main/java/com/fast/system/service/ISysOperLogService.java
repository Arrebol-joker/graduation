package com.fast.system.service;

import java.util.List;
import com.fast.system.domain.SysOperLog;

public interface ISysOperLogService
{
    public List<SysOperLog> selectOperLogList(SysOperLog operLog);

    public int insertOperLog(SysOperLog operLog);

    public SysOperLog selectOperLogById(Long operId);

    public int deleteOperLogByIds(Long[] operIds);

    public int cleanOperLog();
}
