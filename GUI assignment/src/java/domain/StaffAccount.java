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

public class StaffAccount implements Serializable{
    private String profile;
    private String id;
    private String name;
    private String email;
    private String password;
    private char gender;
    
    public StaffAccount(){
    }
    
    public StaffAccount(String profile, String id, String name, String email, String psw, char gender){
        this.profile = profile;
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = psw;
        this.gender = gender;        
    }
    
    public String getProfile(){
        return profile;
    }
    
    public void setProfile(String profile){
        this.profile = profile;
    }
    
    public String getId(){
        return id;
    }
    
    public void setId(String id){
        this.id = id;
    }
    
    public String getName(){
        return name;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public String getEmail(){
        return email;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public String getPsw(){
        return password;
    }
    
    public void setPsw(String psw){
        this.password = psw;
    }
    
    public char getGender(){
        return gender;
    }
    
    public void setGender(char gender){
        this.gender = gender;
    }
    
}
