package com.spring.dao;

import java.util.ArrayList;

//import javax.annotation.Resource;
//import javax.persistence.ValidationMode;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;


import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//import com.spring.model.Employee;
import com.spring.model.Student;

@Component
/*@Resource
@Qualifier("empDao")
@Transactional()*/
public class StudentDao {
	
	@Autowired
	SessionFactory sessionFactory;

	/*public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	*/ @Transactional()
	public int addEmployee(Student stuBean) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		
		Session session = sessionFactory.openSession();
		  Transaction tx = session.beginTransaction();
	    int  i = (Integer) session.save(stuBean);
		
	    tx.commit();
	    session.close();
	    System.out.println("employee saved successfully, Person Details="+stuBean);
	    System.out.println("emp id is "+i);
		return i;
		}
	 @Transactional()
	public Student updateEmployee(Student stuBean) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
	    Student em = (Student) session.merge(stuBean);
	    tx.commit();
	    session.close();
	    System.out.println("Employee update successfully, Person Details="+stuBean);
		return em;
		}
	 @Transactional()
	 @SuppressWarnings("unchecked")
	public ArrayList<Student> listemployee(){
		//ArrayList<Student> empList = new ArrayList<Student>();
		 /*for(Employee empBean : empList){
	            logger.info("Person List::"+p);
	        }*/
		Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		String hql = "FROM Student WHERE dflag = :dflag";
		Query query = session.createQuery(hql);
		query.setParameter("dflag",1);
		return (ArrayList<Student>) query.list();
		}
	 @Transactional()
	public Student getById(int id){
		return (Student) sessionFactory.openSession().get(Student.class, id);
		}
	 @Transactional()
	public Integer deleteEmp(int id) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		 System.out.println("before id :"+id +"dflag"+((Student) sessionFactory.openSession().get(Student.class, id)).getDflag());
		 Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		String hql = "Update Student set dflag = :dflag where id = "+id;
		Query query = session.createQuery(hql);
		query.setParameter("dflag",0);
		int i = query.executeUpdate();
		System.out.println("i is :::"+i);
		
		tx.commit();
		System.out.println("after id:"+id+" dflag = "+((Student) sessionFactory.openSession().get(Student.class, id)).getDflag());
		if(i>0){
			i = 1;
		}else{
			i=0;
		}
		  session.close();
		return i;
	}
	/* @Transactional()
	 @SuppressWarnings("unchecked")
	public ArrayList<Employee> findBySkill(Employee emp) {
		ArrayList<Employee> empList = new ArrayList<Employee>();
		 for(Employee empBean : empList){
	            logger.info("Person List::"+p);
	        }
		Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		String hql = "FROM Employee WHERE skill = :skill";
		Query query = session.createQuery(hql);
		query.setParameter("skill",emp.getSkill());
		return (ArrayList<Employee>) query.list();
		
		
	}*/

}
