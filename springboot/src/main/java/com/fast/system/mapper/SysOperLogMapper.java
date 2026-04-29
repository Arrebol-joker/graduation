package com.fast.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.fast.system.domain.SysOperLog;

@Mapper
public interface SysOperLogMapper
{
    public List<SysOperLog> selectOperLogList(SysOperLog operLog);

    public int insertOperLog(SysOperLog operLog);

    public SysOperLog selectOperLogById(Long operId);

    public int deleteOperLogByIds(Long[] operIds);

    public int cleanOperLog();
}
