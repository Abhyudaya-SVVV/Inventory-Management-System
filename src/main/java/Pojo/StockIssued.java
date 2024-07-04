package Pojo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="StockIssued")
public class StockIssued 
{
   private String ItemName, ItemCompanyName;	
   @Id
   private String SerialNumber;
   private String SvvvNumber, Generation, IssueDate;
   private String AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName;
}
