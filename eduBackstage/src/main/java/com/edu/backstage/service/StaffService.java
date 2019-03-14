package com.edu.backstage.service;

import com.edu.backstage.pojo.CStaff;
import com.edu.backstage.pojo.QueryVO;
import com.edu.backstage.pojo.ResultVO;
import com.github.pagehelper.PageInfo;
import java.util.HashSet;
import java.util.List;

@SuppressWarnings("rawtypes")
public interface StaffService{

    /**
     * 增加一个staff
     *
     * @param staff
     */
    public void saveStaff(CStaff staff);

    /**
     * 分页查询
     *
     * @param page 页码
     * @param rows 每页大小
     * @return
     */
    public PageInfo findPage(QueryVO query,Integer page,Integer rows);


    /**
     * 批量删除
     *
     * @param ids
     */

    public void deleteByIds(Integer[] ids);


    /**
     * 修改部门
     *
     * @param staff
     * @return
     */
    public ResultVO updateStaff(CStaff staff);

    public PageInfo findAdmin(Integer page,Integer rows);

    public void update(Integer id,Integer[] roids,String username,String password);

    public List findRoleIdsByStaffId(Integer staffId);

    /**
     * 使用用户名密码登陆
     *
     * @param username
     * @param password
     */
    public CStaff login(String username,String password);

    public HashSet<String> findRoleByUsername(String username);

    public HashSet<String> findFunctionByUsername(String username);

    public void updatefrom(CStaff staff);
}
