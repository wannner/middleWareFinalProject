package com.example.finalproject.vo;

public class Manager {
    public String managerId;

    public String managerName;

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public Manager() {
    }

    public Manager(String managerId, String managerName) {
        this.managerId = managerId;
        this.managerName = managerName;
    }

    @Override
    public String toString() {
        return "Manager{" +
                "managerId='" + managerId + '\'' +
                ", managerName='" + managerName + '\'' +
                '}';
    }
}
