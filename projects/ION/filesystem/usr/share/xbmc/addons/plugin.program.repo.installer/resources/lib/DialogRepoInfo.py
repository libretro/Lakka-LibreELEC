
import os
from traceback import print_exc

import xbmc
import xbmcgui
from xbmcaddon import Addon


############################################################################
#get actioncodes from keymap.xml
############################################################################
#ACTION_MOVE_LEFT                 = 1
#ACTION_MOVE_RIGHT                = 2
#ACTION_MOVE_UP                   = 3
#ACTION_MOVE_DOWN                 = 4
#ACTION_PAGE_UP                   = 5
#ACTION_PAGE_DOWN                 = 6
#ACTION_SELECT_ITEM               = 7
#ACTION_HIGHLIGHT_ITEM            = 8
ACTION_PARENT_DIR                = 9
ACTION_PREVIOUS_MENU             = 10
#ACTION_SHOW_INFO                 = 11
#ACTION_PAUSE                     = 12
#ACTION_STOP                      = 13
#ACTION_NEXT_ITEM                 = 14
#ACTION_PREV_ITEM                 = 15
#ACTION_MUSIC_PLAY                = 79
#ACTION_MOUSE_CLICK               = 100
ACTION_CONTEXT_MENU              = 117


#__settings__ = Addon( "repository.xbmc.builds" )
#__addonDir__ = __settings__.getAddonInfo( "path" )

#PROFILE_PATH = xbmc.translatePath( __settings__.getAddonInfo( "profile" ) )
#DL_INFO_PATH = os.path.join( PROFILE_PATH, "iddl_data" )


class DialogRepoInfo( xbmcgui.WindowXMLDialog ):

    Addon = Addon( id=os.path.basename( os.getcwd() ) )
    ACTION_CLOSE_DIALOG_LIST = [ ACTION_PARENT_DIR, ACTION_PREVIOUS_MENU, ACTION_CONTEXT_MENU ]
    
    def __init__( self, *args, **kwargs ):
        print "Creating DialogRepoInfo"
        xbmcgui.WindowXMLDialog.__init__( self, *args, **kwargs )
        
        # Get information about the repository
        self._get_repo_info()
        # show dialog
        self.doModal()

    def onInit( self ):
        # Show repo info
        self._show_repo_info()
    
    def onFocus( self, controlID ):
        pass

    def onClick( self, controlID ):
        try:
            kill = None
            if controlID == 199:
                self._close_dialog()
#            elif controlID == 99:
#                pass
        except:
            print_exc()

    def onAction( self, action ):
        if action in self.ACTION_CLOSE_DIALOG_LIST:
            self._close_dialog()

    def _get_repo_info( self ):
        # initialize our dictionary
        print "_get_repo_info"
        self.repo = {}
        self.repo[ "Name" ] = unicode( xbmc.getInfoLabel( "ListItem.Property(Addon.Name)" ), "utf-8" )
        self.repo[ "Description" ] = unicode( xbmc.getInfoLabel( "ListItem.Property(Addon.Description)" ), "utf-8" )
        self.repo[ "Icon" ] = xbmc.getInfoLabel( "ListItem.Property(Addon.Icon)" )
        self.repo[ "Type" ] = unicode( xbmc.getInfoLabel( "ListItem.Property(Addon.Type)" ), "utf-8" )
        self.repo[ "Creator" ] = unicode( xbmc.getInfoLabel( "ListItem.Property(Addon.Creator)" ), "utf-8" )
        #self.repo[ "Version" ] = unicode( xbmc.getInfoLabel( "ListItem.Property(Addon.Version)" ), "utf-8" )
        self.repo[ "Version" ] = None
        
        print self.repo[ "Name" ]
        print self.repo

    def _show_repo_info( self ):
        # set initial apple trailer info
        self._set_repo_info(   name=self.repo[ "Name" ],
                               description=self.repo[ "Description" ],
                               creator=self.repo[ "Creator" ],
                               type=self.repo[ "Type" ],
                               version=self.repo[ "Version" ],
                               icon=self.repo[ "Icon" ],
                           )

    def _set_repo_info( self, name="", description="", creator="", type="", version="", icon="" ):
        # grab the window
        wId = xbmcgui.Window( xbmcgui.getCurrentWindowDialogId() )
        
        # set our info
        wId.setProperty( "Name", name )
        wId.setProperty( "Description", description )
        wId.setProperty( "Creator", creator )
        wId.setProperty( "Type", type )
        if version:
            wId.setProperty( "Version", version )
        wId.setProperty( "Icon", icon )

    def _close_dialog( self ):
        self.close()


if ( __name__ == "__main__" ):
    s = DialogRepoInfo( "DialogRepoInfo.xml", os.path.dirname( os.path.dirname( os.getcwd() ) ), "Default", "720p")
    del s
#if ( __name__ == "__main__" ):
#    DialogDownloadProgress( "DialogRepoInfo.xml", __addonDir__ )
