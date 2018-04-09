package com.rsy.ssd.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.rsy.ssd.domain.User;
import com.rsy.ssd.repository.UserRepository;
import org.apache.struts2.interceptor.RequestAware;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import javax.annotation.Resource;
import java.util.Map;

public class UserAction extends BaseAction implements ModelDriven<User>{

    private User user = new User(); //使用ModelDriven必须要实例化

    //查询分页数据
    public String list() {
        Pageable pageable = PageRequest.of(this.pager, 7);

        Page<User> pager = userRepository.findAll(pageable);

        Integer numberOfElements = pager.getNumberOfElements(); //获取当前页的数据量

        /**
         * 主要为了防止用户在删除数据的时候，最后一页如果就剩一条数据，当在删除这条数据的
         * 时候，总页数会减一，但是我们提交过来的数据还是以前的最后一页，但是最后一页又没有数据
         * 所以我们需要减一查询。
         */
        if(numberOfElements <= 0) {
            pager = userRepository.findAll(PageRequest.of(this.pager - 1, 7));
        }

        requestMap.put("pager", pager);

        return "list";
    }

    //删除
    public String delete() {
        userRepository.deleteUserById(user.getId());
        return "delete";
    }

    @Override
    public User getModel() {
        return user;
    }
}
