# The function downloads IP data from the BFS website and also a px file with information
library(RSelenium)
library(pxR)

f.getIP <- function(){
  # Alternatively, get the json file directly. But I failed to transform it in the right format. If anyone knows...
  # json <- pxR::read.px("https://www.bfs.admin.ch/bfsstatic/dam/assets/15824309/master")
  # pxR::write.json.stat(px, 'data/IP_monthly.json')
  # Setup the server (may vary depending on the computer and browser) -------
  # Define some parameters for Firefox.
  # Most importantly: don't allow popup windows when dowloading + saving files under data folder from getwd()
  eCaps  <- makeFirefoxProfile(list(browser.download.folderList = 2L,
                                    browser.download.dir = paste0(getwd(), "/data"),
                                    browser.helperApps.neverAsk.saveToDisk = "text/plain,application/octet-stream,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                    browser.download.manager.showWhenStarting = FALSE))
  # Run server
  driver <- rsDriver(extraCapabilities = eCaps, browser = "firefox")
  remDr <- driver[["client"]]


  # Get data ----------------------------------------------------------------
  remDr$navigate("https://www.pxweb.bfs.admin.ch/pxweb/en/px-x-0603020000_101/px-x-0603020000_101/px-x-0603020000_101.px")
  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_VariableSelectorValueSelectRepeater_ctl01_VariableValueSelect_VariableValueSelect_SelectAllButton")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_VariableSelectorValueSelectRepeater_ctl02_VariableValueSelect_VariableValueSelect_SelectAllButton")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_VariableSelectorValueSelectRepeater_ctl03_VariableValueSelect_VariableValueSelect_SelectAllButton")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_VariableSelectorValueSelectRepeater_ctl04_VariableValueSelect_VariableValueSelect_SelectAllButton")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_VariableSelectorValueSelectRepeater_ctl05_VariableValueSelect_VariableValueSelect_SelectAllButton")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_OutputFormats_OutputFormats_OutputFormatDropDownList")
  webElem$highlightElement()
  webElem$sendKeysToElement(list("Excel", key = "enter"))

  webElem <- remDr$findElement(using = 'id', value = "ctl00_ContentPlaceHolderMain_VariableSelector1_VariableSelector1_ButtonViewTable")
  webElem$highlightElement() #quick flash as a check we're in the right box
  webElem$clickElement()



  # Close port --------------------------------------------------------------
  #driver$close()
  driver$server$stop()
  rm(driver, remDr)
  gc()
  system("killall /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)

  # Download info about the data --------------------------------------------
  download.file("https://www.pxweb.bfs.admin.ch/api/v1/en/px-x-0603020000_101/px-x-0603020000_101.px","data/IP_monthly.px")

}
