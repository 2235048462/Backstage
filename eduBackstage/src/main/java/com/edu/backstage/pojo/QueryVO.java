package com.edu.backstage.pojo;

import java.util.Date;

public class QueryVO {

	private String name;
	private Integer sex;
	private Date start;
	private Date end;
	private Integer positionId;
	private Integer csCode;
	private String csName;
	private String cuCode;
    private String cuName;
    private String cuTeacher;
    private String sName;
    private String stName;
    private String sClassName;
    private String sScores;
    private String ecName;
    private String euName;
    private String ePlace;
    private Integer csId;

	@Override
	public String toString() {
		return "QueryVO [name=" + name + ", sex=" + sex + ", start=" + start + ", end=" + end + ", positionId="
				+ positionId + ",csCode=" + csCode + ", csName=" + csName + ",cuCode=" + cuCode + ", cuName=" 
				+ cuName + ", cuTeacher=" + cuTeacher + ",sName=" + sName + ",stName=" + stName + ", sClassName=" 
				+ sClassName + ", sScores=" + sScores + ",ecName=" + ecName + ",euName=" 
				+ euName + ", ePlace=" + ePlace + ",csId=" + csId + ",getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	public Integer getCsCode() {
		return csCode;
	}

	public void setCsCode(Integer csCode) {
		this.csCode = csCode;
	}

	public String getCsName() {
		return csName;
	}

	public void setCsName(String csName) {
		this.csName = csName == null ? null : csName.trim();
	}
	
	public String getCuCode() {
        return cuCode;
    }

    public void setCuCode(String cuCode) {
        this.cuCode = cuCode == null ? null : cuCode.trim();
    }

    public String getCuName() {
        return cuName;
    }

    public void setCuName(String cuName) {
        this.cuName = cuName == null ? null : cuName.trim();
    }
    
    public String getCuTeacher() {
        return cuTeacher;
    }

    public void setCuTeacher(String cuTeacher) {
        this.cuTeacher = cuTeacher == null ? null : cuTeacher.trim();
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName == null ? null : sName.trim();
    }

    public String getStName() {
        return stName;
    }

    public void setStName(String stName) {
        this.stName = stName == null ? null : stName.trim();
    }
    
    public String getsClassName() {
        return sClassName;
    }

    public void setsClassName(String sClassName) {
        this.sClassName = sClassName == null ? null : sClassName.trim();
    }
    
    public String getsScores() {
        return sScores;
    }

    public void setsScores(String sScores) {
        this.sScores = sScores == null ? null : sScores.trim();
    }
    
    public String getEcName() {
        return ecName;
    }

    public void setEcName(String ecName) {
        this.ecName = ecName == null ? null : ecName.trim();
    }

    public String getEuName() {
        return euName;
    }

    public void setEuName(String euName) {
        this.euName = euName == null ? null : euName.trim();
    }
    
    public String getePlace() {
        return ePlace;
    }

    public void setePlace(String ePlace) {
        this.ePlace = ePlace == null ? null : ePlace.trim();
    }

	public Integer getCsId() {
		return csId;
	}

	public void setCsId(Integer csId) {
		this.csId = csId;
	}
}
