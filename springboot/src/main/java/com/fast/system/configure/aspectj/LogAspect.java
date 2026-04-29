package com.fast.system.configure.aspectj;

import com.alibaba.fastjson2.JSON;
import com.fast.system.general.annotation.Log;
import com.fast.system.general.utils.SecurityUtils;
import com.fast.system.general.utils.ServletUtils;
import com.fast.system.general.utils.StringUtils;
import com.fast.system.general.utils.ip.IpUtils;
import com.fast.system.domain.SysOperLog;
import com.fast.system.service.ISysOperLogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collection;
import java.util.Date;

@Aspect
@Component
public class LogAspect
{
    private static final Logger log = LoggerFactory.getLogger(LogAspect.class);

    @Autowired
    private ISysOperLogService operLogService;

    public void handleLog(JoinPoint joinPoint, Log controllerLog, Object jsonResult, Exception e)
    {
        try
        {
            SysOperLog operLog = new SysOperLog();
            operLog.setStatus(0);
            operLog.setOperTime(new Date());

            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            operLog.setMethod(className + "." + methodName + "()");

            operLog.setTitle(controllerLog.title());
            operLog.setBusinessType(controllerLog.businessType().ordinal());

            HttpServletRequest request = ServletUtils.getRequest();
            if (request != null)
            {
                operLog.setRequestMethod(request.getMethod());
                operLog.setOperUrl(request.getRequestURI());
                operLog.setOperIp(IpUtils.getIpAddr());
                String location = IpUtils.getIpAddr();
                operLog.setOperLocation(location);
            }

            if (SecurityUtils.getLoginUser() != null)
            {
                operLog.setOperName(SecurityUtils.getUsername());
            }

            if (controllerLog.isSaveRequestData())
            {
                operLog.setOperParam(getRequestParams(joinPoint));
            }

            if (controllerLog.isSaveResponseData() && jsonResult != null)
            {
                operLog.setJsonResult(StringUtils.substring(JSON.toJSONString(jsonResult), 0, 2000));
            }

            if (e != null)
            {
                operLog.setStatus(1);
                operLog.setErrorMsg(StringUtils.substring(e.getMessage(), 0, 2000));
            }

            operLogService.insertOperLog(operLog);
        }
        catch (Exception ex)
        {
            log.error("记录操作日志异常", ex);
        }
    }

    @AfterReturning(pointcut = "@annotation(controllerLog)", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, Log controllerLog, Object jsonResult)
    {
        handleLog(joinPoint, controllerLog, jsonResult, null);
    }

    @AfterThrowing(pointcut = "@annotation(controllerLog)", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Log controllerLog, Exception e)
    {
        handleLog(joinPoint, controllerLog, null, e);
    }

    private String getRequestParams(JoinPoint joinPoint)
    {
        StringBuilder params = new StringBuilder();
        if (joinPoint.getArgs() != null)
        {
            for (Object arg : joinPoint.getArgs())
            {
                if (arg == null) continue;
                if (arg instanceof HttpServletRequest
                        || arg instanceof HttpServletResponse
                        || arg instanceof BindingResult
                        || arg instanceof MultipartFile
                        || arg instanceof Collection
                        || isMultipartFileArray(arg))
                {
                    continue;
                }
                params.append(JSON.toJSONString(arg)).append(" ");
            }
        }
        return StringUtils.substring(params.toString(), 0, 2000);
    }

    private boolean isMultipartFileArray(Object arg)
    {
        return arg instanceof MultipartFile[];
    }
}
