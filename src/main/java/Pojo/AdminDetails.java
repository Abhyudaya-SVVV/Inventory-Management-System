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
@Table(name="AdminRegistration")
public class AdminDetails 
{
  @Id
  private String AdminEnrollmentNumber;
  private String AdminName, AdminEmail, AdminContact, AdminBranchName, AdminDeptName, AdminInstituteName, AdminProfilePhoto;
  
}
