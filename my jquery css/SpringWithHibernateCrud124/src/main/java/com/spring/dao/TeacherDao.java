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
import com.spring.model.Teacher;

@Component
/*@Resource
@Qualifier("empDao")
@Transactional()*/
public class TeacherDao {
	
	@Autowired
	SessionFactory sessionFactory;

	/*public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	*/ @Transactional()
	public int addEmployee(Teacher techBean) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		
		Session session = sessionFactory.openSession();
		  Transaction tx = session.beginTransaction();
	    int  i = (Integer) session.save(techBean);
		
	    tx.commit();
	    session.close();
	    System.out.println("employee saved successfully, Person Details="+techBean);
	    System.out.println("emp id is "+i);
		return i;
		}
	 @Transactional()
	public Teacher updateEmployee(Teacher techBean) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		Teacher em = (Teacher) session.merge(techBean);
	    tx.commit();
	    session.close();
	    System.out.println("Employee update successfully, Person Details="+techBean);
		return em;
		}
	 @Transactional()
	 @SuppressWarnings("unchecked")
	public ArrayList<Teacher> listemployee(){
		//ArrayList<Student> empList = new ArrayList<Student>();
		 /*for(Employee empBean : empList){
	            logger.info("Person List::"+p);
	        }*/
		Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		String hql = "FROM Teacher WHERE dflag = :dflag";
		Query query = session.createQuery(hql);
		query.setParameter("dflag",1);
		return (ArrayList<Teacher>) query.list();
		}
	 @Transactional()
	public Teacher getById(int id){
		return (Teacher) sessionFactory.openSession().get(Teacher.class, id);
		}
	 @Transactional()
	public Integer deleteEmp(int id) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SystemException{
		 System.out.println("before id :"+id +"dflag"+((Teacher) sessionFactory.openSession().get(Teacher.class, id)).getDflag());
		 Session session= sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		String hql = "Update Teacher set dflag = :dflag where id = "+id;
		Query query = session.createQuery(hql);
		query.setParameter("dflag",0);
		int i = query.executeUpdate();
		System.out.println("i is :::"+i);
		
		tx.commit();
		System.out.println("after id:"+id+" dflag = "+((Teacher) sessionFactory.openSession().get(Teacher.class, id)).getDflag());
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
