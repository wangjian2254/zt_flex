package util
{
	import control.Loading;
	
	import httpcontrol.RemoteUtil;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.ResultEvent;

	public class InfoUtil
	{
		public function InfoUtil()
		{
		}
		
		public static function init():void{
			userRefresh();
			scxRefresh();
			codeRefresh();
			siteRefresh();
			orderbhRefresh();
			openOrderRefresh();
			planListRefresh();
		}
		
		public static var codeObj:Object=new Object();
		public static var orderlistbhObj:Object=new Object();
		public static var codeToBHlistObj:Object=new Object();
		
		public static var orderlistToZYBHlistObj:Object=new Object();
		
		[Bindable]
		public static var planjjcd:ArrayCollection=new ArrayCollection([{"id":0,"text":"非常紧急"},{"id":1,"text":"一般紧急"},{"id":2,"text":"标准生产"},{"id":3,"text":"库备"}]);
		
		
		public static function orderlistToOrderbhRefresh(orderlistid:*,fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getZYDHByOrderList");
			operation.addEventListener(ResultEvent.RESULT, resultZYDHByOrderlist);
			
			RemoteUtil.openLoading();
			operation.send(orderlistid);
		}
		public static function resultZYDHByOrderlist(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				
				for(var k:String in result.result){
					orderlistToZYBHlistObj[k]=new ArrayCollection(result.result[k] as Array);
				}
			}
		}
		
		
		[Bindable]
		public static var orderbhList:ArrayCollection=new ArrayCollection();
		
		public static function orderbhRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllOrderNo");
			operation.addEventListener(ResultEvent.RESULT, resultAllOrderNo);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
		}
		public static function resultAllOrderNo(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				orderbhList.removeAll();
				orderbhList.addAll(new ArrayCollection(result.result as Array));
			}
		}
		
		[Bindable]
		public static var planList:ArrayCollection=new ArrayCollection();
		
		public static function planListRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllPlanNo");
			operation.addEventListener(ResultEvent.RESULT, resultPlanList);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
		}
		public static function resultPlanList(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				planList.removeAll();
				planList.addAll(new ArrayCollection(result.result as Array));
			}
		}
		
		[Bindable]
		public static var userList:ArrayCollection=new ArrayCollection();
		
		public static function userRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllUser");
			operation.addEventListener(ResultEvent.RESULT, resultAllUser);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
		}
		public static function resultAllUser(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				userList.removeAll();
				userList.addAll(new ArrayCollection(result.result as Array));
			}
		}
		
		[Bindable]
		public static var scxList:ArrayCollection=new ArrayCollection();
		
		public static function scxRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllScx");
			operation.addEventListener(ResultEvent.RESULT, resultAllScx);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
		}
		
		public static function resultAllScx(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				scxList.removeAll();
				scxList.addAll(new ArrayCollection(result.result as Array));
			}
		}
		[Bindable]
		public static var codeList:ArrayCollection=new ArrayCollection();
		
		public static function codeRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllCode");
			operation.addEventListener(ResultEvent.RESULT, resultAllCode);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
			codeObj=new Object();
		}
		
		public static function resultAllCode(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				codeList.removeAll();
				codeList.addAll(new ArrayCollection(result.result as Array));
			}
		}
		[Bindable]
		public static var siteList:ArrayCollection=new ArrayCollection();
		[Bindable]
		public static var allsiteList:ArrayCollection=new ArrayCollection();
		
		public static function siteRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getAllProductSite");
			operation.addEventListener(ResultEvent.RESULT, resultAllProductSite);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
		}
		
		public static function resultAllProductSite(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				siteList.removeAll();
				allsiteList.removeAll();
				var newlist:ArrayCollection=new ArrayCollection(result.result as Array);
				var obj:Object;
				for(var i:int=0;i<newlist.length;i++){
					obj=newlist.getItemAt(i);
					if(obj.isaction==true){
						siteList.addItem(obj);
					}
					allsiteList.addItem(obj);
				}
			}
		}
		[Bindable]
		public static var openOrderList:ArrayCollection=new ArrayCollection();
		[Bindable]
		public static var openOrderBHList:ArrayCollection=new ArrayCollection();
		
		public static function openOrderRefresh(fun:Function=null):void{
			var operation:AbstractOperation=RemoteUtil.getOperation("getOrderIsOpen");
			operation.addEventListener(ResultEvent.RESULT, resultOrderIsOpen);
			if(fun!=null){
				operation.addEventListener(ResultEvent.RESULT, fun);
			}
			RemoteUtil.openLoading();
			operation.send();
			orderlistbhObj=new Object();
			codeToBHlistObj=new Object();
		}
		
		public static function resultOrderIsOpen(e:ResultEvent):void{
			var result:Object=e.result;
			if(result.success==true){
				openOrderList.removeAll();
				openOrderList.addAll(new ArrayCollection(result.result.orderlist as Array));
				openOrderBHList.removeAll();
				openOrderBHList.addAll(new ArrayCollection(result.result.orderddbh as Array));
				var keyobj:Object=new Object();
				for each(var obj:Object in openOrderBHList){
					keyobj["h"+obj.id]=obj.ddbh;
					
				}
				for each(var item:Object in openOrderList){
						item['ddbhstr']=keyobj["h"+item.ddbh];
				}
			}
		}
		
	}
}