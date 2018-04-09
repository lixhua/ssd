package com.rsy.ssd.action;

import com.opensymphony.xwork2.ActionSupport;
import com.rsy.ssd.repository.UserRepository;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import javax.annotation.Resource;
import java.util.Map;

public class BaseAction extends ActionSupport implements RequestAware, SessionAware{

    protected Map<String, Object> requestMap;

    protected Map<String, Object> sessionMap;

    protected Object datas; //返回json

    protected Integer pager = 0;

    @Resource
    protected UserRepository userRepository;

    @Override
    public void setRequest(Map<String, Object> request) {
        this.requestMap = request;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.sessionMap = session;
    }

    public Object getDatas() {
        return datas;
    }

    public void setDatas(Object datas) {
        this.datas = datas;
    }

    public Integer getPager() {
        return pager;
    }

    public void setPager(Integer pager) {
        this.pager = pager;
    }
}
