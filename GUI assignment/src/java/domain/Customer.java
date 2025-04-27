/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author User
 */
import java.io.Serializable;

public class Customer implements Serializable{
    private int CusID;
    private String CusName;
    private String CusPhone;
    private String CusEmail;
    private String CusUserName;
    private String CusPsw;
    private String CusGender;
    private String Address;
    
    public Customer(){
    }
    
    public Customer(int CusID, String CusName, String CusPhone, String CusEmail, 
            String CusUserName, String CusPsw, String CusGender, String Address){
        this.CusID = CusID;
        this.CusName = CusName;
        this.CusPhone = CusPhone;
        this.CusEmail = CusEmail;
        this.CusUserName = CusUserName;
        this.CusPsw = CusPsw;
        this.CusGender = CusGender;
        this.Address = Address;
    }

    public int getCusID() {
        return CusID;
    }

    public void setCusID(int CusID) {
        this.CusID = CusID;
    }

    public String getCusName() {
        return CusName;
    }

    public void setCusName(String CusName) {
        this.CusName = CusName;
    }

    public String getCusPhone() {
        return CusPhone;
    }

    public void setCusPhone(String CusPhone) {
        this.CusPhone = CusPhone;
    }

    public String getCusEmail() {
        return CusEmail;
    }

    public void setCusEmail(String CusEmail) {
        this.CusEmail = CusEmail;
    }

    public String getCusUserName() {
        return CusUserName;
    }

    public void setCusUserName(String CusUserName) {
        this.CusUserName = CusUserName;
    }

    public String getCusPsw() {
        return CusPsw;
    }

    public void setCusPsw(String CusPsw) {
        this.CusPsw = CusPsw;
    }

    public String getCusGender() {
        return CusGender;
    }

    public void setCusGender(String CusGender) {
        this.CusGender = CusGender;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }
   
}
