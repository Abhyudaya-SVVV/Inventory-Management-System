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
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="IssueItems")
public class IssueItems 
{ 
  private String FacultyName;
  @Id
  private String FacultyEnrollmentNumber;
  private String FacultyContact, FacultyEmail, FacultyBranchName, FacultyDeptName, FacultyInstituteName;
  private String IssueDate, ReturnDate, ItemName, ItemCompanyName, ItemSvvvNumber, ItemSerialNumber, Generation, Remark;
}
