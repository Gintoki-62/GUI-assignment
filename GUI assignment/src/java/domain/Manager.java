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

public class Manager implements Serializable{
    private String profile;
    private String id;
    private String name;
    private String email;
    private String password;
    
    public Manager(){
    }
    
    public Manager(String profile, String id, String name, String email, String psw){
        this.profile = profile;
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = psw;        
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
 
}
