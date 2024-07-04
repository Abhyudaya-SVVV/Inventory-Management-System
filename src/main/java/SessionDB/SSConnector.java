package SessionDB;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

public class SSConnector 
{
  public static Session getSession()
  {
	SessionFactory sf = new AnnotationConfiguration().configure().buildSessionFactory(); 
	Session ss = sf.openSession();		 
    return ss;
  }
}
