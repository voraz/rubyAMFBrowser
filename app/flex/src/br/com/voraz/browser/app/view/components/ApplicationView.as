package br.com.voraz.browser.app.view.components
{
	import br.com.voraz.browser.app.ApplicationFacade;
	import br.com.voraz.browser.app.view.ApplicationMediator;
	
	import mx.core.Application;
	
	public class ApplicationView extends Application
	{
		
		private var _index:Index;
		private var mediator:ApplicationMediator;
		
		public function ApplicationView()
		{
			super();
		}
		
		public function set index(index:Index):void
		{
			this._index = index;
			ApplicationFacade.getInstance().startup(this);
			mediator = new ApplicationMediator(this);
		}
		
		public function get index():Index
		{
			return _index;
		}		
		
	}
}