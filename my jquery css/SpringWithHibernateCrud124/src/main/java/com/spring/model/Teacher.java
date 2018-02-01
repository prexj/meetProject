package com.spring.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
//import javax.persistence.TableGenerator;
//import javax.persistence.Transient;

@Entity
@Table(name="teacher")
public class Teacher implements Serializable{
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id")
	private int id;
	
	@Column(name="firstname")
	private String firstname;
	
	@Column(name ="lastname")
	private String lastname;
	
	//@Column(name="address")
	//private String address;
	
	@Column(name="gender")
	private String gender;

	@Column(name="dflag")
	private int dflag;
	
	
	public int getDflag() {
		return dflag;
	}
	public void setDflag(int dflag) {
		this.dflag = dflag;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	/*public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}*/
	
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	
	@Override
	public String toString() {
		return "Teacher [id=" + id + ", firstname=" + firstname
				+ ", lastname=" + lastname +/*", address=" + address
				+  ", dflag="*/ + dflag + "]";/*;, skill=" + skill +
*/	}
	
	

}

