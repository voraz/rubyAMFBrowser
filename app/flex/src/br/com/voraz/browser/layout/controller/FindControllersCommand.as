package br.com.voraz.browser.layout.controller
{
	import br.com.voraz.browser.layout.model.LayoutProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class FindControllersCommand extends SimpleCommand
	{
		override public function execute(notification:INotification) : void
		{
			var proxy:LayoutProxy = facade.retrieveProxy(LayoutProxy.NAME) as LayoutProxy;
			if(proxy==null)
			{
				proxy = new LayoutProxy();
				facade.registerProxy(proxy);
			}
			proxy.show();		
		}
	}
}