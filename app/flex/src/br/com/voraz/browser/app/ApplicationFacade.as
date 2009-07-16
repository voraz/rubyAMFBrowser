package br.com.voraz.browser.app
{
	import br.com.voraz.browser.app.controller.StartupCommand;
	import br.com.voraz.browser.layout.controller.FindControllersCommand;
	
	import mx.core.Application;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const STARTUP:String = "startup";
		public static const FIND_CONTROLLERS_LAYOUT:String = "findControllersLayout";
		
		public static function getInstance():ApplicationFacade
		{
			if(instance == null)
			{
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		
		public function startup(applicationView:Application):void
		{
			sendNotification( STARTUP, applicationView );
		}		
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand( STARTUP, StartupCommand );
			registerCommand( FIND_CONTROLLERS_LAYOUT, FindControllersCommand);
		}
	}
}