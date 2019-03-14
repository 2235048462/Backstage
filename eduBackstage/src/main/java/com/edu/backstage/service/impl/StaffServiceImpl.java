package com.edu.backstage.service.impl;

import com.edu.backstage.dao.CStaffMapper;
import com.edu.backstage.dao.CStaffRoleMapper;
import com.edu.backstage.pojo.CStaff;
import com.edu.backstage.pojo.CStaffRole;
import com.edu.backstage.pojo.QueryVO;
import com.edu.backstage.pojo.ResultVO;
import com.edu.backstage.service.StaffService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StaffServiceImpl implements StaffService{


    @Autowired
    private CStaffMapper staffMapper;

    @Autowired
    private CStaffRoleMapper staffRoleMapper;

    public static void main(String[] args){
        System.out.println(DigestUtils.md5Hex("123456"));
    }

    @Override
    public void saveStaff(CStaff staff){
        Date date = new Date();
        staff.setCreateTime(date);
        staff.setUpdateTime(date);
        staffMapper.insert(staff);
    }

    @SuppressWarnings({"rawtypes","unchecked"})
    @Override
    public PageInfo findPage(QueryVO query,Integer page,Integer rows){
        //分页插件的使用
        PageHelper.startPage(page,rows);
        //查询
        List list = new ArrayList();
        //查询数据库
        list = staffMapper.findListWithPname(query);
        //查询数据交给分页插件，自动查询总数
        PageInfo info = new PageInfo(list);
        System.out.println("总数：" + info.getTotal() + " 当前页数据：" + info.getList());
        return info;
    }

    @SuppressWarnings("unused")
    @Override
    public void deleteByIds(Integer[] ids){

        for(int i = 0;i < ids.length;i++){
            //假如ids有10个，删除到第六个出错了
            //2，事务回滚，都没有删除成功
            int deleteByPrimaryKey = staffMapper.deleteByPrimaryKey(ids[i]);
        }

    }

    @SuppressWarnings("unused")
    @Override
    public ResultVO updateStaff(CStaff staff){
        Integer id = staff.getId();
        Date date = new Date();
        staff.setBirthday(staffMapper.selectByPrimaryKey(id).getBirthday());
        staff.setEntry(staffMapper.selectByPrimaryKey(id).getEntry());
        if(null != id){
            staffMapper.updateByPrimaryKey(staff);
            return new ResultVO("修改成功");
        }
        return new ResultVO("修改失败");
    }

    @SuppressWarnings({"rawtypes","unchecked"})
    @Override
    public PageInfo findAdmin(Integer page,Integer rows){
        PageHelper.startPage(page,rows);
        List<Map> list = staffMapper.findAdmin();
        return new PageInfo(list);
    }

    @Override
    public void update(Integer id,Integer[] roids,String username,String password){
        CStaff staff = new CStaff();
        staff.setId(id);
        //使用md5加密密码
        password = DigestUtils.md5Hex(password);
        staff.setPassword(password);
        staff.setUsername(username);
        staffMapper.updateByPrimaryKeySelective(staff);
        //删除管理员对应的角色数据
        staffRoleMapper.deleteByStaffID(id);
        //新增数据
        for(Integer roleid: roids){
            CStaffRole sr = new CStaffRole();
            sr.setRoleId(roleid);
            sr.setStaffId(id);
            staffRoleMapper.insert(sr);
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List findRoleIdsByStaffId(Integer staffId){
        return staffRoleMapper.selectByStaffID(staffId);
    }

    @Override
    public CStaff login(String username,String password){
        //加密密码
        password = DigestUtils.md5Hex(password);
        ;
        //查询
        List<CStaff> staffs = staffMapper.login(username,password);
        if(staffs.size() > 0){
            return staffs.get(0);
        }
        return null;
    }

    @Override
    public HashSet<String> findRoleByUsername(String username){
        return staffMapper.findRoleByUsername(username);
    }


    @Override
    public HashSet<String> findFunctionByUsername(String username){
        return staffMapper.findFunctionByUsername(username);
    }


    @Override
    public void updatefrom(CStaff staff){
        //使用md5加密密码
        String password = DigestUtils.md5Hex(staff.getPassword());
        staff.setPassword(password);
        staffMapper.updatefrom(staff);
    }


}
