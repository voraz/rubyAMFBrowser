package br.com.voraz.browser.app.view
{
	import br.com.voraz.browser.app.model.ApplicationProxy;
	import br.com.voraz.browser.app.view.components.ApplicationView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		private var applicationProxy:ApplicationProxy = new ApplicationProxy();
		private var proxy:ApplicationProxy = new ApplicationProxy();
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			facade.registerProxy(applicationProxy);
		}
		
		private function get applicationView():ApplicationView
		{
			return viewComponent as ApplicationView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					];
		}
		
		override public function handleNotification(notification:INotification):void
		{

		}
		
	}
}