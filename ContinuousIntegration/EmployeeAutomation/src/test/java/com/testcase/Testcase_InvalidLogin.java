package com.testcase;


import java.sql.Driver;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.testng.Reporter;
import org.testng.SkipException;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.automation.Testbase;



public class Testcase_InvalidLogin extends Testbase {
    
    
    @BeforeClass
    public void enterDataInRegistrationFiled() throws InterruptedException
    {   Thread.sleep(1000);
        driver.findElement(By.xpath("//a[contains(text(),'Add Employee')]")).click();
        enterDataInTextBoxField("Employee Name:", "Automation");
        enterDataInTextBoxField("Employee Age:", "25");
        enterDataInTextBoxField("Employee Salary:", "20000");
        enterDataInTextBoxField("Employee Address:", "plot not 9 puja vihar");
        driver.findElement(By.xpath("//input[@value='Submit']")).sendKeys(Keys.RETURN);
      }
	

  @Test
    public void verifyEmployeeISAdded()
    {
	  try {
		List<String> expectedTable = _getExpectedResultTable("Automation","25","20000","plot not 9 puja vihar");
	        List<String> actualTable = getDataFromTable().subList(1, getDataFromTable().size()-1);
                System.out.println(actualTable);
                Assert.assertEquals(expectedTable, actualTable, "table are notsame");
                driver.findElement(By.xpath("//a[contains(text(),'Delete')]")).click();
	 } catch (Exception e) {
		 
		 e.printStackTrace();
		}
    }
  
  
  @Test
  public void verifyEmployeeTabledisDeleted()
  {
        try {
             Assert.assertFalse((driver.findElement(By.cssSelector("html>body>table"))).isDisplayed(), "Employee table is not sisplayed");
       } catch (Exception e) {
               
              
              }
  }
  
  public void enterDataInTextBoxField(String registrationFieldName, String data) {
      WebElement registrationTable = driver.findElement(By.tagName("table"));
      List<WebElement> rows = registrationTable.findElements(By.tagName("tr"));
      for (WebElement row : rows) {
        
          List<WebElement> nameElement = row.findElements(By.tagName("td"));
          if (nameElement == null)
              continue;

          String fldName = nameElement.get(0).getText();
          if (!fldName.equalsIgnoreCase(registrationFieldName))
              continue;

          WebElement fldDataWebElement = row.findElement(By.tagName("input"));
          fldDataWebElement.sendKeys(data);
      }
  }
  
  public List<String> getDataFromTable() {
      List<String> actualTableHeading = new ArrayList<String>();
     WebElement employeeTable = driver.findElement(By.cssSelector("html>body>table>tbody"));
     List<WebElement> tableHeadingRow = employeeTable.findElements(By.tagName("tr"));
      List<WebElement> tableHeadingData = tableHeadingRow.get(1).findElements(By.tagName("td"));
      for (WebElement webElement : tableHeadingData) {
          String tableHeadingdata = webElement.getText();
          actualTableHeading.add(tableHeadingdata);
      }
      return actualTableHeading;
  }

  private List<String> _getExpectedResultTable(String... heandingsAndData) {
       List<String> tableHeadingAndData = new ArrayList<String>();
      for (String tableHeadingData : heandingsAndData) {
          tableHeadingAndData.add((tableHeadingData));
      }
      return tableHeadingAndData;
  }     
  

  
}
