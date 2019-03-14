package com.edu.backstage.dao;

import com.edu.backstage.pojo.CStaffRole;
import java.util.List;

public interface CStaffRoleMapper{
    int deleteByStaffID(Integer staffId);

    int insert(CStaffRole record);

    int insertSelective(CStaffRole record);

    List<CStaffRole> selectByStaffID(Integer staffId);

    int updateByPrimaryKeySelective(CStaffRole record);

    int updateByPrimaryKey(CStaffRole record);
}