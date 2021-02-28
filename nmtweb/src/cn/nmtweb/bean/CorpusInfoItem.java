package cn.nmtweb.bean;

public class CorpusInfoItem {
    private String name;
    private String comeFrom;
    private String ciDate;
    private int isUsed;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComeFrom() {
        return comeFrom;
    }

    public void setComeFrom(String comeFrom) {
        this.comeFrom = comeFrom;
    }

    public String getCiDate() {
        return ciDate;
    }

    public void setCiDate(String ciDate) {
        this.ciDate = ciDate;
    }

    public int getIsUsed() {
        return isUsed;
    }

    public void setIsUsed(int isUsed) {
        this.isUsed = isUsed;
    }
}
