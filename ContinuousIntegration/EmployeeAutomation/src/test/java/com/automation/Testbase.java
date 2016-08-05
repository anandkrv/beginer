package com.automation;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.events.EventFiringWebDriver;
import org.testng.Reporter;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeSuite;





public class Testbase {

    public static Properties config = null;
    public static Properties OR = null;
    public WebDriver wbDv = null;
    public static EventFiringWebDriver driver = null;
  

    @BeforeSuite
    public void intilize()
    {
        // loading all the configuration values
        try {
            
            config = new Properties();
            String string = System.getProperty("os.name").toString();
            System.out.println(string);
            
/*             if (string.contains("Windows 7"))
                {
                 FileInputStream fp = new FileInputStream(System.getProperty("user.dir")+"\\config\\MainConfig.properties");
                 config.load(fp);
                  
                }
                else {*/
//                    FileInputStream fp = new FileInputStream(System.getProperty("user.dir")+"/config/MainConfig.properties");
                    FileInputStream fp = new FileInputStream(System.getProperty("user.dir")+File.separator+"config" + File.separator+
                    		"MainConfig.properties");
                    config.load(fp);
                    
//                }
            
            
            wbDv= new FirefoxDriver();
            driver = new EventFiringWebDriver(wbDv);

            // Entering the website URL
            Reporter.log("Navigate to url");
            driver.navigate().to(config.getProperty("URL"));

            // maximizing the Browser window
            driver.manage().window().maximize();

        } catch (Exception e) {

            e.printStackTrace();
        }

    }

    public static WebElement getObject(String xpathKey) {

        // Initialize the xpath and Checking the type of the locator
        String strXpath = OR.getProperty(xpathKey);

        if (strXpath.startsWith("//")) {

            return driver.findElement(By.xpath(OR.getProperty(xpathKey).trim()));


        } else {

            return driver.findElement(By.cssSelector(OR.getProperty(xpathKey).trim()));
        }
    }

    @AfterSuite
    public void closeBrowser() {

        driver.close();
        driver.quit();
    }


}
