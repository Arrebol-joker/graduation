package com.fast.system.configure.web.service;

import com.fast.system.domain.SysUserOnline;
import com.fast.system.general.core.domain.model.LoginUser;
import com.fast.system.general.core.redis.LocalCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class SysOnlineService
{
    @Autowired
    private LocalCache localCache;

    private static final String ONLINE_TOKEN_KEY = "online_tokens";

    public void recordLogin(LoginUser loginUser, String tokenId)
    {
        SysUserOnline online = new SysUserOnline();
        online.setTokenId(tokenId);
        online.setUserName(loginUser.getUsername());
        if (loginUser.getUser() != null)
        {
            online.setNickName(loginUser.getUser().getNickName());
            online.setUserId(loginUser.getUserId());
        }
        online.setIpaddr(loginUser.getIpaddr());
        online.setLoginLocation(loginUser.getLoginLocation());
        online.setBrowser(loginUser.getBrowser());
        online.setOs(loginUser.getOs());
        online.setLoginTime(new Date());

        localCache.setCacheMapValue(ONLINE_TOKEN_KEY, tokenId, online);
    }

    public void removeLogin(String tokenId)
    {
        localCache.deleteCacheMapValue(ONLINE_TOKEN_KEY, tokenId);
    }

    public SysUserOnline getOnlineByTokenId(String tokenId)
    {
        return localCache.getCacheMapValue(ONLINE_TOKEN_KEY, tokenId);
    }

    public Collection<SysUserOnline> selectOnlineList(String userName, String ipaddr)
    {
        Map<String, SysUserOnline> onlineMap = localCache.getCacheMap(ONLINE_TOKEN_KEY);
        if (onlineMap == null || onlineMap.isEmpty())
        {
            return new ArrayList<>();
        }

        List<SysUserOnline> result = new ArrayList<>();
        for (SysUserOnline online : onlineMap.values())
        {
            if (userName != null && !userName.isEmpty()
                    && !online.getUserName().toLowerCase().contains(userName.toLowerCase()))
            {
                continue;
            }
            if (ipaddr != null && !ipaddr.isEmpty()
                    && !online.getIpaddr().contains(ipaddr))
            {
                continue;
            }
            result.add(online);
        }

        result.sort((a, b) -> b.getLoginTime().compareTo(a.getLoginTime()));
        return result;
    }
}
