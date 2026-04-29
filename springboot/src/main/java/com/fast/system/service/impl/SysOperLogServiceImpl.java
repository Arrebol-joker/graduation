package com.fast.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fast.system.domain.SysOperLog;
import com.fast.system.mapper.SysOperLogMapper;
import com.fast.system.service.ISysOperLogService;

@Service
public class SysOperLogServiceImpl implements ISysOperLogService
{
    @Autowired
    private SysOperLogMapper operLogMapper;

    @Override
    public List<SysOperLog> selectOperLogList(SysOperLog operLog)
    {
        return operLogMapper.selectOperLogList(operLog);
    }

    @Override
    public int insertOperLog(SysOperLog operLog)
    {
        return operLogMapper.insertOperLog(operLog);
    }

    @Override
    public SysOperLog selectOperLogById(Long operId)
    {
        return operLogMapper.selectOperLogById(operId);
    }

    @Override
    public int deleteOperLogByIds(Long[] operIds)
    {
        return operLogMapper.deleteOperLogByIds(operIds);
    }

    @Override
    public int cleanOperLog()
    {
        return operLogMapper.cleanOperLog();
    }
}
