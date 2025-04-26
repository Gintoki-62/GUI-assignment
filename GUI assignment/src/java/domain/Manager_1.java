/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yenxi
 */
@Entity
@Table(name = "MANAGER", catalog = "", schema = "NBUSER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Manager_1.findAll", query = "SELECT m FROM Manager_1 m"),
    @NamedQuery(name = "Manager_1.findByProfile", query = "SELECT m FROM Manager_1 m WHERE m.profile = :profile"),
    @NamedQuery(name = "Manager_1.findByManagerid", query = "SELECT m FROM Manager_1 m WHERE m.managerPK.managerid = :managerid"),
    @NamedQuery(name = "Manager_1.findByManagername", query = "SELECT m FROM Manager_1 m WHERE m.managerPK.managername = :managername"),
    @NamedQuery(name = "Manager_1.findByPassword", query = "SELECT m FROM Manager_1 m WHERE m.password = :password"),
    @NamedQuery(name = "Manager_1.findByEmail", query = "SELECT m FROM Manager_1 m WHERE m.email = :email")})
public class Manager_1 implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ManagerPK managerPK;
    @Size(max = 255)
    @Column(name = "PROFILE")
    private String profile;
    @Size(max = 50)
    @Column(name = "PASSWORD")
    private String password;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 50)
    @Column(name = "EMAIL")
    private String email;

    public Manager_1() {
    }

    public Manager_1(ManagerPK managerPK) {
        this.managerPK = managerPK;
    }

    public Manager_1(String managerid, String managername) {
        this.managerPK = new ManagerPK(managerid, managername);
    }

    public ManagerPK getManagerPK() {
        return managerPK;
    }

    public void setManagerPK(ManagerPK managerPK) {
        this.managerPK = managerPK;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (managerPK != null ? managerPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Manager_1)) {
            return false;
        }
        Manager_1 other = (Manager_1) object;
        if ((this.managerPK == null && other.managerPK != null) || (this.managerPK != null && !this.managerPK.equals(other.managerPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domain.Manager_1[ managerPK=" + managerPK + " ]";
    }
    
}
