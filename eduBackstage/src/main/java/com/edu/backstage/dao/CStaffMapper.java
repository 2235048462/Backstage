package com.edu.backstage.dao;

import com.edu.backstage.pojo.CStaff;
import com.edu.backstage.pojo.QueryVO;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

@SuppressWarnings("rawtypes")
public interface CStaffMapper{
    int deleteByPrimaryKey(Integer id);

    int insert(CStaff record);

    int insertSelective(CStaff record);

    CStaff selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CStaff record);

    int updateByPrimaryKey(CStaff record);

    List<CStaff> findList(QueryVO query);

    List<Map> findListWithPname(QueryVO query);

    List<Map> findAdmin();

    List<CStaff> login(@Param("username") String username,@Param("password") String password);

    HashSet<String> findRoleByUsername(@Param("username") String username);

    HashSet<String> findFunctionByUsername(@Param("username") String username);

    void updatefrom(CStaff staff);
}