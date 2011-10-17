"""
   Module retrieving repositories info from XBMC Wiki
   by Temhil 
"""

from BeautifulSoup import SoupStrainer
from BeautifulSoup import BeautifulSoup
from traceback import print_exc
import re
import urllib
#
# Constants
# 
#__settings__ = sys.modules[ "__main__" ].__settings__
#__language__ = sys.modules[ "__main__" ].__language__



def getRepoList(pageUrl, destination=None, addItemFunc=None, progressBar=None,  msgFunc=None ):
    """
    Retrieve Blogs list passing each item to the cb addItemFunc
    return Next page URL
    """
    #print "getRepoList"
    result = "OK"

    # Get HTML page...
    htmlSource = urllib.urlopen( pageUrl ).read()    
    #print htmlSource
    
    # Parse response...
    beautifulSoup = BeautifulSoup( htmlSource )
    itemRepoList = beautifulSoup.findAll("tr") 
    print itemRepoList
    for repo in itemRepoList:
        try:
            #print repo
            #print "----"
            repoInfo = {}
            tdList = repo.findAll ("td")
            if tdList:
                repoInfo["name"] = tdList[0].a.string.strip()
                repoInfo["description"] = tdList[1].string.strip()
                repoInfo["owner"] = tdList[2].string.strip()
                repoInfo["repoUrl"] = tdList[3].a["href"]
                try:
                    repoInfo["ImageUrl"] = tdList[4].a["href"]
                except:
                    repoInfo["ImageUrl"] = None
                #print repoInfo
                
                #if progressBar != None:
                if addItemFunc != None:
                    if repoInfo["repoUrl"].endswith("zip"):
                        addItemFunc( repoInfo )
                    else:
                        print "Invalid URL for the repository %s - URL=%s"%(repoInfo["name"], repoInfo["repoUrl"])
        except:
            print "getRepoList - error parsing html - impossible to retrieve Blog info"
            print_exc()
            result = "ERROR"  
    return result


    
if ( __name__ == "__main__" ):
    print "Wiki parser test"
    
    repoListUrl = "http://wiki.xbmc.org/index.php?title=Unofficial_Add-on_Repositories"
    print repoListUrl
    getRepoList(repoListUrl)
